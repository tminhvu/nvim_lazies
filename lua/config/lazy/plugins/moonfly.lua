local M = {
    'bluz71/vim-moonfly-colors',
    lazy = true,
    config = function ()
        vim.g.nightflyWinSeparator = 2
        vim.g.nightflyUnderlineMatchParen = true
        vim.api.nvim_command [[colorscheme moonfly]]
    end
}

return M
