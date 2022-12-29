local M = {
    dir = '~/Dev/lua/vim-nightfly-colors',
    lazy = false,
    config = function ()
        vim.g.nightflyWinSeparator = 2
        vim.g.nightflyUnderlineMatchParen = true
        vim.g.nightflyTransparent = true
        vim.cmd.colorscheme 'nightfly'
    end
}

return M
