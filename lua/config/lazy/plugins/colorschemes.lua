-- catppuccin: latte when 'background' is light, mocha when dark. Neovide sets 'background' from the
-- Windows light/dark setting and terminal Neovim from the terminal's colors; :ThemeToggle flips it.
local M = {
  'catppuccin/nvim',
  name = 'catppuccin',
  lazy = false,
  priority = 1000,
  init = function()
    vim.api.nvim_create_user_command('ThemeToggle', function()
      vim.o.background = vim.o.background == 'dark' and 'light' or 'dark'
    end, { desc = 'Switch the colorscheme between its light and dark variant' })
  end,
  config = function()
    require('catppuccin').setup({ background = { light = 'latte', dark = 'mocha' } })
    vim.cmd.colorscheme('catppuccin')
  end,
}

return M
