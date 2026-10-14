-- Colorschemes with a light and a dark variant. Each picks its variant from 'background', which
-- Neovide sets from the Windows light/dark setting and terminal Neovim from the terminal's colors.
-- Try them with :colorscheme rose-pine / catppuccin / vscode / default; :ThemeToggle flips light/dark.
-- Only the active one loads at startup; lazy.nvim loads the others on :colorscheme.
local M = {
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = false,
    priority = 1000,
    init = function()
      vim.api.nvim_create_user_command('ThemeToggle', function()
        vim.o.background = vim.o.background == 'dark' and 'light' or 'dark'
      end, { desc = 'Switch the colorscheme between its light and dark variant' })
    end,
    config = function()
      require('rose-pine').setup({ dark_variant = 'main' }) -- light: dawn
      vim.cmd.colorscheme('rose-pine')
    end,
  },
  { 'catppuccin/nvim', name = 'catppuccin', lazy = true },   -- light: latte, dark: mocha
  { 'Mofiqul/vscode.nvim', name = 'vscode', lazy = true },   -- Light+ / Dark+
}

return M
