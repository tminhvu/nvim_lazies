local M = {
    --'kvrohit/mellow.nvim',
    dir = '~/Dev/lua/mellow.nvim',
    lazy = true,
    config = function()
        vim.g.mellow_italic_comments = true   --Make comments italic
        vim.g.mellow_italic_keywords = false  --Make keywords italic
        vim.g.mellow_italic_booleans = false  --Make booleans italic
        vim.g.mellow_italic_functions = false --Make functions italic
        vim.g.mellow_italic_variables = false --Make variables italic
        vim.g.mellow_bold_comments = false    --	Make comments bold
        vim.g.mellow_bold_keywords = true     --	Make keywords bold
        vim.g.mellow_bold_booleans = true     --	Make booleans bold
        vim.g.mellow_bold_functions = true    --	Make functions bold
        vim.g.mellow_bold_variables = true    --	Make variables bold
        vim.g.mellow_transparent = false      --Disable background color
        vim.cmd.colorscheme 'mellow'
    end
}
return M
