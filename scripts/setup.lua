-- Neovim-side setup, run by install.ps1 / install.sh once the system tools are in place:
--   nvim --headless "+lua dofile([[scripts/setup.lua]])"
-- Installs plugins at the lazy-lock.json versions, compiles the treesitter parsers, installs the
-- LSP servers with mason, installs the Neovide config and adds an `n` alias for neovide.
-- Safe to run again after every pull.

local repo = vim.fs.dirname(vim.fs.dirname(vim.fs.normalize(debug.getinfo(1, 'S').source:sub(2))))
local is_windows = vim.fn.has('win32') == 1
local failures = {}

local function log(msg) io.stdout:write(msg .. '\n') end
local function step(name) log('\n== ' .. name) end
local function fail(msg)
  table.insert(failures, msg)
  log('FAILED: ' .. msg)
end
local function finish()
  if #failures > 0 then
    log(('\nsetup finished with %d problem(s):'):format(#failures))
    for _, f in ipairs(failures) do log('  - ' .. f) end
    vim.cmd('cquit 1')
  end
  log('\nsetup finished: everything is installed')
  vim.cmd('qa!')
end

-- Neovim only loads the config from stdpath('config'); a clone anywhere else would set up some other config
local function same_path(a, b)
  a, b = vim.fs.normalize(a), vim.fs.normalize(b)
  if is_windows then a, b = a:lower(), b:lower() end
  return a == b
end
if not same_path(vim.fn.stdpath('config'), repo) then
  fail(('this repo is at %s, but Neovim reads its config from %s; clone it there'):format(repo, vim.fn.stdpath('config')))
  finish()
end

step('plugins (lazy.nvim, pinned to lazy-lock.json)')
require('lazy').restore({ wait = true, show = false })
for name, p in pairs(require('lazy.core.config').plugins) do
  if not p._.installed then fail('plugin not installed: ' .. name) end
end
log(('%d plugins installed'):format(vim.tbl_count(require('lazy.core.config').plugins)))

step('treesitter parsers')
-- tree.lua installs synchronously when there is no UI, so this returns once they're compiled
require('lazy').load({ plugins = { 'nvim-treesitter' } })
for _, lang in ipairs(require('nvim-treesitter.configs').get_ensure_installed_parsers()) do
  if not require('nvim-treesitter.parsers').has_parser(lang) then fail('treesitter parser missing: ' .. lang) end
end

step('LSP servers (mason)')
require('lazy').load({ plugins = { 'mason-lspconfig.nvim' } })
local registry = require('mason-registry')
-- not the blocking form: if the refresh errors, that one waits forever
local refreshed
registry.refresh(function(success) refreshed = success end)
if not vim.wait(5 * 60 * 1000, function() return refreshed ~= nil end, 200) or not refreshed then
  fail('could not refresh the mason registry')
  finish()
end
local to_package = require('mason-lspconfig').get_mappings().lspconfig_to_package
local pending = 0
for _, server in ipairs(require('mason-lspconfig.settings').current.ensure_installed) do
  local name = to_package[server] or server
  local ok, pkg = pcall(registry.get_package, name)
  if not ok then
    fail('unknown mason package: ' .. name)
  elseif pkg:is_installed() then
    log('ok         ' .. name)
  else
    log('installing ' .. name)
    pending = pending + 1
    pkg:install({}, function(success, err)
      pending = pending - 1
      if success then log('installed  ' .. name) else fail(name .. ': ' .. tostring(err)) end
    end)
  end
end
if not vim.wait(30 * 60 * 1000, function() return pending == 0 end, 500) then
  fail('timed out waiting for mason installs')
end

step('Neovide config')
local src = vim.fs.joinpath(repo, 'neovide', 'config.toml')
local dir = is_windows and vim.fs.joinpath(vim.env.APPDATA, 'neovide')
    or vim.fs.joinpath(vim.env.XDG_CONFIG_HOME or vim.fs.joinpath(vim.env.HOME, '.config'), 'neovide')
local dst = vim.fs.joinpath(dir, 'config.toml')
vim.fn.mkdir(dir, 'p')
-- keep a backup if the installed config differs (local edits or an older version)
if vim.uv.fs_stat(dst) and not vim.deep_equal(vim.fn.readfile(dst), vim.fn.readfile(src)) then
  assert(vim.uv.fs_copyfile(dst, dst .. '.bak'))
  log('backed up ' .. dst .. ' -> ' .. dst .. '.bak')
end
assert(vim.uv.fs_copyfile(src, dst))
log('installed ' .. dst)

step('`n` alias for neovide')
-- added once, appended so the rest of the file is untouched
local function add_alias(file, alias)
  local existing = vim.uv.fs_stat(file) and vim.fn.readfile(file, 'b') or {}
  if vim.tbl_contains(existing, alias) or vim.tbl_contains(existing, alias .. '\r') then
    log('ok         already in ' .. file)
    return
  end
  if vim.fn.executable('n') == 1 then
    log('note: the alias hides the existing `n` at ' .. vim.fn.exepath('n'))
  end
  vim.fn.mkdir(vim.fs.dirname(file), 'p')
  -- start on a fresh line if the file doesn't end with one
  local lines = (#existing > 0 and existing[#existing] ~= '') and { '', alias } or { alias }
  vim.fn.writefile(lines, file, 'a')
  log('added to ' .. file .. ' (open a new terminal to use it)')
end

if is_windows then
  local profile = vim.trim(vim.fn.system({ 'powershell', '-NoProfile', '-Command', '$PROFILE' }))
  add_alias(profile, 'Set-Alias -Name n -Value neovide')
else
  local home = vim.env.HOME
  local shell = vim.fs.basename(vim.env.SHELL or '')
  if shell == 'bash' then
    add_alias(vim.fs.joinpath(home, '.bashrc'), 'alias n=neovide')
  elseif shell == 'zsh' then
    add_alias(vim.fs.joinpath(vim.env.ZDOTDIR or home, '.zshrc'), 'alias n=neovide')
  elseif shell == 'fish' then
    local fish_dir = vim.fs.joinpath(vim.env.XDG_CONFIG_HOME or vim.fs.joinpath(home, '.config'), 'fish')
    add_alias(vim.fs.joinpath(fish_dir, 'config.fish'), 'alias n neovide')
  else
    log('unknown shell "' .. shell .. '": add `alias n=neovide` to your shell config yourself')
  end
end

finish()
