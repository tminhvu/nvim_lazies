local M = {
    'nvim-treesitter/nvim-treesitter',
    event = 'BufReadPost',
    lazy = false,
    branch = 'master',
    build = ':TSUpdate',
    dependencies = {
        'windwp/nvim-ts-autotag',
        'nvim-treesitter/playground'
    },
    config = function()
        require 'nvim-treesitter.configs'.setup {
            ensure_installed = { "c", "java", "bash", "css", "lua", "html", "javascript", "typescript", "tsx", "json",
                "markdown", "markdown_inline", "dart", "astro", "vimdoc", "go" },
            sync_install = true,
            auto_install = false,
            ignore_install = {},
            modules = {},
            highlight = {
                enable = true, -- false will disable the whole extension
                additional_vim_regex_highlighting = false
            },
            incremental_selection = {
                enable = false,
            },
            indent = {
                enable = false,
            },
            autotag = {
                enable = true,
            },
            playground = {
                enable = true,
            },
            textobjects = {
                enable = false,
                select = {
                    enable = false,
                },
                move = {
                    enable = false,
                },
            },
        }
    end,
}

return M
