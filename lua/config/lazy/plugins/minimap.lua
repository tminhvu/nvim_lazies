-- Minimap, like VS Code's (neominimap): a column on the right with the code drawn in braille dots in
-- its syntax colors (treesitter), with diagnostics, git changes and search hits marked. A split of its
-- own, so it covers no code. Click in it to jump; <leader>mm toggles it, <leader>mf focuses it.
local M = {
  'Isrothy/neominimap.nvim',
  lazy = false, -- loads its parts on its own; lazy-loading it is not supported
  keys = {
    { '<leader>mm', '<cmd>Neominimap Toggle<cr>', desc = 'Minimap: toggle' },
    { '<leader>mf', '<cmd>Neominimap ToggleFocus<cr>', desc = 'Minimap: focus / back' },
  },
  init = function()
    vim.g.neominimap = {
      auto_enable = true,
      -- a split on the right (one per tab, for the current window) rather than a float over the code
      layout = 'split',
      split = {
        minimap_width = 20,
        fix_width = true,
        close_if_last_window = true, -- :q on the last editor window doesn't leave the minimap behind
      },
      click = { enabled = true },
      search = { enabled = true },
    }
  end,
}

return M
