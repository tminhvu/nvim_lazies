local M = {
    dir = '~/Dev/lua/vim-nightfly-colors',
    lazy = true,
    config = function ()
        vim.g.nightflyWinSeparator = 2
        vim.g.nightflyUnderlineMatchParen = true
        vim.api.nvim_command [[colorscheme nightfly]]
    end
}

return M
