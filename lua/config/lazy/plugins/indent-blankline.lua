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
                highlight = 'NonText',
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
    end
}

return M
