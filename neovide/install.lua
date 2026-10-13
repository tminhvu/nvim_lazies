-- Copy neovide/config.toml to where Neovide reads it on this OS,
-- and on Windows add an `n` alias for neovide to the PowerShell profile.
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

-- `n` launches neovide from PowerShell; added once, appended so the rest of the profile is untouched
if vim.fn.has('win32') == 1 then
  local profile = vim.trim(vim.fn.system({ 'powershell', '-NoProfile', '-Command', '$PROFILE' }))
  local alias = 'Set-Alias -Name n -Value neovide'
  local existing = vim.uv.fs_stat(profile) and vim.fn.readfile(profile, 'b') or {}
  if vim.tbl_contains(existing, alias) or vim.tbl_contains(existing, alias .. '\r') then
    print('`n` alias already in ' .. profile)
  else
    vim.fn.mkdir(vim.fs.dirname(profile), 'p')
    -- start on a fresh line if the profile doesn't end with one
    local lines = (#existing > 0 and existing[#existing] ~= '') and { '', alias } or { alias }
    vim.fn.writefile(lines, profile, 'a')
    print('added `n` alias to ' .. profile .. ' (open a new terminal to use it)')
  end
end
