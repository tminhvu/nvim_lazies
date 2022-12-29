require('config.settings')
require('config.keymaps')
require('config.statusline-winbar')
require('config.lazy')
require('config.diagnostics')

if vim.g.neovide ~= nil then
    print('Runing inside Neovide')
    require('config.settings-neovide')
end
