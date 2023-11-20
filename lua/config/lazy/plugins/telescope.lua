local M = {
    'nvim-telescope/telescope.nvim',
    cmd = { "Telescope" },
    dependencies = {
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
        local telescope = require('telescope')
        telescope.setup {
            defaults = {
                selection_caret = '  > ',
                file_ignore_patterns = { "^node_modules/", "^.git/", "^.cache/", "^bin/", "%.pdf", "%.mkv",
                    "%.mp4", "%.zip", "^flutter_jank_metrics", "^test/" },
                previewer = true,
                path_display = {
                    shorten = 1
                },
                dynamic_preview_title = true,
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
                        preview_cutoff = 40,
                        prompt_position = "bottom",
                        width = 0.8
                    }
                },
                selection_strategy = "reset",
                sorting_strategy = "ascending",
                mappings = {
                    n = {
                        ['dd'] = require('telescope.actions').delete_buffer
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
