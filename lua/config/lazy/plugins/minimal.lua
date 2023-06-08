local M = {
    dir='~/Dev/lua/minimal.nvim',
    lazy = false,
    config = function()
        vim.g.minimal_italic_comments = true --Make comments italic
        vim.g.minimal_italic_keywords = false --Make keywords italic
        vim.g.minimal_italic_booleans = false --Make booleans italic
        vim.g.minimal_italic_functions = false --Make functions italic
        vim.g.minimal_italic_variables = false --Make variables italic
        vim.g.minimal_transparent_background = false --Disable background color
        vim.cmd.colorscheme 'minimal-base16'
    end
}

return M
