require('config.settings')
require('config.keymaps')
require('config.statusline-winbar')
require('config.diagnostics')
require('config.lazy')

--[[
if vim.g.neovide ~= nil then
    print('Runing inside Neovide')
    require('config.settings-neovide')
end
--]]
