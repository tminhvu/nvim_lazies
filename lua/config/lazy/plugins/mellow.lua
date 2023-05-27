local M = {
    'kvrohit/mellow.nvim',
    lazy = true,
    config = function()
        vim.gmellow_italic_comments = true   --Make comments italic
        vim.gmellow_italic_keywords = false  --Make keywords italic
        vim.gmellow_italic_booleans = false  --Make booleans italic
        vim.gmellow_italic_functions = false --Make functions italic
        vim.gmellow_italic_variables = false --Make variables italic
        vim.gmellow_bold_comments = false    --	Make comments bold
        vim.gmellow_bold_keywords = true     --	Make keywords bold
        vim.gmellow_bold_booleans = true    --	Make booleans bold
        vim.gmellow_bold_functions = true    --	Make functions bold
        vim.gmellow_bold_variables = true   --	Make variables bold
        vim.gmellow_transparent = false      --Disable background color
        vim.cmd.colorscheme 'mellow'
    end
}
return M
