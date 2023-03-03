local M = {
    'nvim-treesitter/nvim-treesitter',
    event = 'BufReadPost',
    dependencies = {
        'windwp/nvim-ts-autotag',
        'HiPhish/nvim-ts-rainbow2',
    },
    config = function()
        require('nvim-treesitter.configs').setup {
            ensure_installed = { "c", "java", "bash", "css", "lua", "html", "javascript", "typescript", "tsx", "json", "markdown", "markdown_inline" },
            sync_install = false,
            highlight = {
                enable = true, -- false will disable the whole extension
                additional_vim_regex_highlighting = false
            },
            incremental_selection = {
                enable = false,
            },
            indent = {
                enable = true,
            },
            autotag = {
                enable = true
            },
            textobjects = {
                select = {
                    enable = false,
                },
                move = {
                    enable = false,
                },
            },
            rainbow = {
                enable = true,
                -- list of languages you want to disable the plugin for
                --disable = {},
                -- Which query to use for finding delimiters
                query = 'rainbow-parens',
                -- Highlight the entire buffer all at once
                strategy = require 'ts-rainbow.strategy.global',
            }
        }
    end
}

return M
