-- Neovide-only settings; does nothing in a terminal
if not vim.g.neovide then
  return
end

-- zoom: Ctrl+= bigger, Ctrl+- smaller, Ctrl+0 reset (not saved across restarts)
vim.g.neovide_scale_factor = 1.0

local function zoom(factor)
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * factor
end

vim.keymap.set({ 'n', 'v', 'i' }, '<C-=>', function() zoom(1.1) end, { desc = 'Neovide: zoom in' })
vim.keymap.set({ 'n', 'v', 'i' }, '<C-->', function() zoom(1 / 1.1) end, { desc = 'Neovide: zoom out' })
vim.keymap.set({ 'n', 'v', 'i' }, '<C-0>', function() vim.g.neovide_scale_factor = 1.0 end, { desc = 'Neovide: reset zoom' })
