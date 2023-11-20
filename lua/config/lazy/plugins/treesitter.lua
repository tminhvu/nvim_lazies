local M = {
    'nvim-treesitter/nvim-treesitter',
    event = 'BufReadPost',
    commit = '33eb472b459f1d2bf49e16154726743ab3ca1c6d', -- remove when dart freezing is solved
    dependencies = {
        'windwp/nvim-ts-autotag',
    },
    config = function()
        require('nvim-treesitter.configs').setup {
            ensure_installed = { "c", "java", "bash", "css", "lua", "html", "javascript", "typescript", "tsx", "json",
                "markdown", "markdown_inline", "dart", "astro" },
            sync_install = true,
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
    end
}

return M
