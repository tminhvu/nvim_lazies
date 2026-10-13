-- Copy neovide/config.toml to where Neovide reads it on this OS,
-- and add an `n` alias for neovide to the shell config
-- (PowerShell profile on Windows; .bashrc / .zshrc / config.fish elsewhere).
-- Usage (from the nvim config dir, in a normal terminal): nvim -l neovide/install.lua

local src = vim.fs.joinpath(vim.fs.dirname(vim.fs.normalize(debug.getinfo(1, 'S').source:sub(2))), 'config.toml')

local dir
if vim.fn.has('win32') == 1 then
  dir = vim.fs.joinpath(vim.env.APPDATA, 'neovide')
else
  dir = vim.fs.joinpath(vim.env.XDG_CONFIG_HOME or vim.fs.joinpath(vim.env.HOME, '.config'), 'neovide')
end
local dst = vim.fs.joinpath(dir, 'config.toml')

vim.fn.mkdir(dir, 'p')

-- keep a backup if the installed config differs (local edits or an older version)
if vim.uv.fs_stat(dst) and not vim.deep_equal(vim.fn.readfile(dst), vim.fn.readfile(src)) then
  assert(vim.uv.fs_copyfile(dst, dst .. '.bak'))
  print('backed up ' .. dst .. ' -> ' .. dst .. '.bak')
end

assert(vim.uv.fs_copyfile(src, dst))
print('installed ' .. src .. ' -> ' .. dst)

-- `n` launches neovide from the shell; added once, appended so the rest of the file is untouched
local function add_alias(file, alias)
  local existing = vim.uv.fs_stat(file) and vim.fn.readfile(file, 'b') or {}
  if vim.tbl_contains(existing, alias) or vim.tbl_contains(existing, alias .. '\r') then
    print('`n` alias already in ' .. file)
    return
  end
  if vim.fn.executable('n') == 1 then
    print('note: the alias hides the existing `n` at ' .. vim.fn.exepath('n'))
  end
  vim.fn.mkdir(vim.fs.dirname(file), 'p')
  -- start on a fresh line if the file doesn't end with one
  local lines = (#existing > 0 and existing[#existing] ~= '') and { '', alias } or { alias }
  vim.fn.writefile(lines, file, 'a')
  print('added `n` alias to ' .. file .. ' (open a new terminal to use it)')
end

if vim.fn.has('win32') == 1 then
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
    print('unknown shell "' .. shell .. '": add `alias n=neovide` to your shell config yourself')
  end
end
