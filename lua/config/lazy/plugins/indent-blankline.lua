local M = { 'lukas-reineke/indent-blankline.nvim',
    event = 'BufReadPost',
    config = function()
        -- vim.opt.list = true
        -- vim.opt.listchars = "lead:"
        require('indent_blankline').setup {
            buftype_exclude = { "terminal", "nofile" },
            filetype_exclude = {
                "help",
                "NvimTree",
            },

            -- , '┆', '┊' ┆ ┇ ┊ ┋ ┆ ┇ ┊ ┋ '|', '¦', '┆', '┊' ⋅   
            char = "",
            show_trailing_blankline_indent = false,
            use_treesitter = true,
            space_char_blankline = ' ',
            context_patterns = {
                "class",
                "return",
                "function",
                "method",
                "^if",
                "^while",
                "jsx_element",
                "^for",
                "^object",
                "^table",
                "block",
                "arguments",
                "if_statement",
                "else_clause",
                "jsx_element",
                "jsx_self_closing_element",
                "try_statement",
                "catch_clause",
                "import_statement",
                "operation_type",
            },
        }
    end
}

return M
