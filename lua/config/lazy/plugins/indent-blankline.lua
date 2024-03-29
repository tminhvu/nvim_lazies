local M = {
    'lukas-reineke/indent-blankline.nvim',
    event = 'BufReadPost',
    main = 'ibl',
    opts = {},
    config = function()
        require('ibl').setup {
            viewport_buffer = {
                min = 30,
                max = 100,
            },
            indent = {
                -- , '┆', '┊' ┆ ┇ ┊ ┋ ┆ ┇ ┊ ┋ '|', '¦', '┆', '┊' ⋅   
                char = '┊',
                --highlight = '',
            },
            exclude = {
                filetypes = { "help", "NvimTree", },
            },
            scope = {
                char = '│',
                enabled = true,
                show_start = false,
                show_end = false,
                highlight = '@comment',
                include = {
                    node_type = {
                        dart = {
                            "*"
                        }
                    }
                    -- Make every node type valid. Note that this can lead to some weird
                    -- behavior
                    --{
                    --    node_type = { ["*"] = { "*" } },
                    --}
                }
            },
        }

        vim.api.nvim_set_hl(0, 'IblIndent', { fg = "#141414" })
        vim.api.nvim_set_hl(0, '@ibl.indent.char.1', { fg = "#141414" })
        vim.api.nvim_set_hl(0, 'IblScope', { fg = '#414141' })
        vim.api.nvim_set_hl(0, '@ibl.scope.char.1', { fg = '#414141' })
    end
}

return M
