local M =  {
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
                    "%.mp4", "%.zip" },
                previewer = true,
                layout_strategy = "horizontal",
                layout_config = {
                    horizontal = {
                        prompt_position = "top",
                        preview_width = 0.5,
                        results_width = 0.8,
                    },
                    vertical = {
                        mirror = false,
                    },
                    width = 0.87,
                    height = 0.80,
                    preview_cutoff = 120,
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
            }
        }
        telescope.load_extension 'fzf'
   end
}

return M
