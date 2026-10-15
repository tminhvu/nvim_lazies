-- Neovim-side setup, run by install.ps1 / install.sh once the system tools are in place:
--   nvim --headless "+lua dofile([[scripts/setup.lua]])"
-- Installs plugins at the lazy-lock.json versions, builds the treesitter parsers, installs the
-- LSP servers with mason, installs the Neovide, Alacritty and tmux configs, adds an `n` alias for
-- neovide and, on Windows, bash-style Tab completion to PowerShell.
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
local function install_parsers()
  -- nvim-treesitter's `main` branch: Neovim 0.12+, and `tree-sitter build` compiles every parser
  if vim.fn.has('nvim-0.12') == 0 then
    return fail('nvim-treesitter needs Neovim 0.12 or newer; this is ' .. tostring(vim.version()))
  end
  for _, tool in ipairs({ 'tree-sitter', 'tar', 'curl' }) do
    if vim.fn.executable(tool) == 0 then return fail(tool .. ' is not on PATH') end
  end
  local plugin = require('lazy.core.config').plugins['nvim-treesitter']
  -- the archived `master` branch compiled its parsers into the plugin folder, which would shadow
  -- the ones `main` installs (under stdpath('data')/site)
  for _, leftover in ipairs({ 'parser', 'parser-info' }) do
    local dir = vim.fs.joinpath(plugin.dir, leftover)
    vim.fn.delete(dir, 'rf')
    -- Windows keeps a parser a running Neovim has loaded; the new ones come first on the rtp anyway
    if vim.uv.fs_stat(dir) then
      log('note: could not remove all of ' .. dir .. ' (in use by a running Neovim?); run this again after closing it')
    end
  end
  -- the restore above may have just switched the plugin over from `master`: use the new modules
  for name in pairs(package.loaded) do
    if name:match('^nvim%-treesitter') then package.loaded[name] = nil end
  end
  local ts = require('nvim-treesitter')
  local wanted = require('lazy.core.plugin').values(plugin, 'opts', false).ensure_installed
  local ok, err = ts.install(wanted, { summary = true }):pwait(30 * 60 * 1000)
  if not ok then fail('installing treesitter parsers: ' .. tostring(err)) end
  local installed = ts.get_installed('parsers')
  for _, lang in ipairs(wanted) do
    if not vim.list_contains(installed, lang) then fail('treesitter parser missing: ' .. lang) end
  end
  log(('%d parsers installed'):format(#installed))
end
install_parsers()

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

-- install `dst` as the repo files `srcs` joined together (plus `extra` lines), keeping a backup if
-- the installed one differs (local edits or an older version)
local function install_config(dst, srcs, extra)
  local lines = {}
  for _, src in ipairs(srcs) do vim.list_extend(lines, vim.fn.readfile(vim.fs.joinpath(repo, src))) end
  vim.list_extend(lines, extra or {})
  vim.fn.mkdir(vim.fs.dirname(dst), 'p')
  if vim.uv.fs_stat(dst) and not vim.deep_equal(vim.fn.readfile(dst), lines) then
    assert(vim.uv.fs_copyfile(dst, dst .. '.bak'))
    log('backed up ' .. dst .. ' -> ' .. dst .. '.bak')
  end
  vim.fn.writefile(lines, dst)
  log('installed ' .. dst)
end
local app_config = is_windows and vim.env.APPDATA
    or vim.env.XDG_CONFIG_HOME or vim.fs.joinpath(vim.env.HOME, '.config')

step('Neovide config')
install_config(vim.fs.joinpath(app_config, 'neovide', 'config.toml'), { 'neovide/config.toml' })

step('Alacritty config')
-- start in ~/Repos when it exists (tmux, its shell, then opens there); Alacritty needs the full path
local repos = vim.fs.normalize(vim.fs.joinpath(vim.uv.os_homedir(), 'Repos'))
install_config(vim.fs.joinpath(app_config, 'alacritty', 'alacritty.toml'), { 'alacritty/alacritty.toml' },
  vim.fn.isdirectory(repos) == 1 and { '', '[general]', ("working_directory = '%s'"):format(repos) } or {})

step('tmux config')
-- tmux on Linux, psmux (tmux for Windows) on Windows: both read ~/.tmux.conf
install_config(vim.fs.joinpath(vim.uv.os_homedir(), '.tmux.conf'),
  { 'tmux/tmux.conf', is_windows and 'tmux/windows.conf' or 'tmux/linux.conf' })

-- a line for a shell's startup file: added once, appended so the rest of the file is untouched
local function add_line(file, line)
  local existing = vim.uv.fs_stat(file) and vim.fn.readfile(file, 'b') or {}
  if vim.tbl_contains(existing, line) or vim.tbl_contains(existing, line .. '\r') then
    log('ok         already in ' .. file)
    return
  end
  vim.fn.mkdir(vim.fs.dirname(file), 'p')
  -- start on a fresh line if the file doesn't end with one
  local lines = (#existing > 0 and existing[#existing] ~= '') and { '', line } or { line }
  vim.fn.writefile(lines, file, 'a')
  log('added to ' .. file .. ' (open a new terminal to use it)')
end
local function add_alias(file, alias)
  if vim.fn.executable('n') == 1 then
    log('note: the alias hides the existing `n` at ' .. vim.fn.exepath('n'))
  end
  add_line(file, alias)
end
local profile = is_windows and vim.trim(vim.fn.system({ 'powershell', '-NoProfile', '-Command', '$PROFILE' }))

if is_windows then
  step('PowerShell: bash-style Tab completion')
  -- Tab completes as far as the matches agree, a second Tab lists them all (instead of cycling
  -- through full matches)
  add_line(profile, 'Set-PSReadLineKeyHandler -Key Tab -Function Complete')
end

step('`n` alias for neovide')
if is_windows then
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
