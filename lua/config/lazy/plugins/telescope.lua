local M = {
    'nvim-telescope/telescope.nvim',
    --commit = 'a4432dfb9b0b960c4cbc8765a42dc4fe2e029e8f',
    cmd = { "Telescope" },
    dependencies = {
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
        local telescope = require('telescope')
        telescope.setup {
            defaults = {
                border = true,
                selection_caret = ' ',
                file_ignore_patterns = { "^node_modules/", "^.git/", "^.cache/", "^bin/", "%.pdf", "%.mkv",
                    "%.mp4", "%.zip", "^flutter_jank_metrics", "^test/" },
                previewer = true,
                path_display = {
                    filename_first = true,
                },
                dynamic_preview_title = true,
                preview = {
                    treesitter = false,
                },
                layout_strategy = "horizontal",
                layout_config = {
                    horizontal = {
                        prompt_position = "bottom",
                        preview_width = 0.5,
                        results_width = 0.5,
                        width = 0.90,
                        height = 0.80,
                    },
                    vertical = {
                        height = 0.9,
                        preview_cutoff = 10,
                        prompt_position = "bottom",
                        width = 0.8
                    }
                },
                selection_strategy = "reset",
                sorting_strategy = "ascending",
                mappings = {
                    n = {
                        ['dd'] = require('telescope.actions').delete_buffer,
                        ["<C-p>"] = require("telescope.actions.layout").toggle_preview,
                        ["<A-l>"] = require("telescope.actions.layout").cycle_layout_next,
                        ["<C-l>"] = require("telescope.actions").preview_scrolling_right,
                        ["<C-h>"] = require("telescope.actions").preview_scrolling_left,
                        ["<C-k>"] = require("telescope.actions").preview_scrolling_up,
                        ["<C-j>"] = require("telescope.actions").preview_scrolling_down,
                    },
                }
            },
            pickers = {
                current_buffer_fuzzy_find = { sorting_strategy = 'ascending' },
                find_files = {
                    hidden = true,
                    no_ignore = false
                }
            },
        }
        telescope.load_extension 'fzf'
    end
}

return M
