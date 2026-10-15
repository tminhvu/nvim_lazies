-- Minimap, like VS Code's: a column on the right with the file shrunk into block characters, the
-- visible part and the cursor line marked, and search hits, diagnostics and git changes in color.
-- Opens with the editor. <leader>mm toggles it; <leader>mf focuses it (move, then <CR> jumps there).
local M = {
  'nvim-mini/mini.map',
  event = 'VeryLazy',
  config = function()
    local map = require('mini.map')
    map.setup({
      -- in priority order: the first one to mark a map line colors it
      integrations = {
        map.gen_integration.builtin_search(),
        map.gen_integration.diagnostic(),
        map.gen_integration.gitsigns(),
      },
    })
    vim.keymap.set('n', '<leader>mm', map.toggle, { desc = 'Minimap: toggle' })
    vim.keymap.set('n', '<leader>mf', map.toggle_focus, { desc = 'Minimap: focus (move, <CR> to jump)' })
    map.open()
  end,
}

return M
