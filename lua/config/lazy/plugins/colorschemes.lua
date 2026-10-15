-- catppuccin: latte when 'background' is light, mocha when dark. Neovide sets 'background' from the
-- Windows light/dark setting and terminal Neovim from the terminal's colors (light when the terminal
-- doesn't say); :ThemeToggle flips it.
-- Also available, loaded only on :colorscheme and following 'background' the same way:
--   :colorscheme vscode   VS Code Light+ / Dark+
--   :colorscheme claude   Claude's palette (orange #D97757, warm neutrals); claude-light / claude-dark pin one
local M = {
  {
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
      -- Neovim asks the terminal for its background color before reading this config. Without an
      -- answer (Alacritty on Windows: the system ConPTY swallows the question) 'background' is
      -- still unset and defaults to dark; default to light (latte) instead
      if not vim.api.nvim_get_option_info2('background', {}).was_set then
        vim.o.background = 'light'
      end
      require('catppuccin').setup({ background = { light = 'latte', dark = 'mocha' } })
      vim.cmd.colorscheme('catppuccin')
    end,
  },
  { 'Mofiqul/vscode.nvim', name = 'vscode', lazy = true },
  { 'markosnarinian/claude.nvim', name = 'claude', lazy = true },
}

return M
