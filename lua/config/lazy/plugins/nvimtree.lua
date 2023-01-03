local M = { 'kyazdani42/nvim-tree.lua',
    cmd = { 'NvimTreeToggle' },
    config = function()
        require 'nvim-tree'.setup {
            view = {
                preserve_window_proportions = true,
                number = false,
                signcolumn = "yes",
                --adaptive_size = true
                side = "left",
                hide_root_folder = true
            },
            diagnostics = {
                enable = true,
                show_on_dirs = true,
                icons = {
                    -- hint = "",
                    -- info = "",
                    -- warning = "",
                    -- error = "",
                    hint = "H",
                    info = "I",
                    warning = "W",
                    error = "E",
                }, severity = {
                    min = vim.diagnostic.severity.WARN,
                    max = vim.diagnostic.severity.ERROR
                },
            },
            actions = {
                open_file = {
                    resize_window = true,
                    window_picker = {
                        chars = "123456789"
                    }
                },
            },
            renderer = {
                indent_markers = {
                    enable = true
                },
                add_trailing = true,
                full_name = true,
                icons = {
                    git_placement = "after",
                    glyphs = {
                        git = {
                            unstaged = "us",
                            staged = "st",
                            unmerged = "um",
                            renamed = "rn",
                            untracked = "ut",
                            deleted = "de",
                            ignored = "ig",
                        },
                    },
                    padding = "  "
                },

                highlight_opened_files = "all"
            },
            git = {
                enable = true,
                ignore = true,
                show_on_dirs = true,
                timeout = 400,
            },
        }
    end
}

return M
