-- Copy neovide/config.toml to where Neovide reads it on this OS.
-- Usage (from the nvim config dir): nvim -l neovide/install.lua

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
