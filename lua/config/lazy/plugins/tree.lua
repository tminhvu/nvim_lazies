local M = {
  'nvim-treesitter/nvim-treesitter',
  event = 'VeryLazy',
  --lazy = false,
  branch = 'master',
  --build = ':TSUpdate',
  config = function()
    require 'nvim-treesitter.configs'.setup {
      ensure_installed = { "c", "java", "bash", "css", "lua", "html", "javascript", "typescript", "tsx", "json",
        "markdown", "markdown_inline", "dart", "astro", "vimdoc", "go" },
      sync_install = false,
      auto_install = false,
      ignore_install = {},
      modules = {},
      highlight = {
        enable = false,
        additional_vim_regex_highlighting = false
      },
      incremental_selection = {
        enable = false,
      },
      indent = {
        enable = false,
      },
      textobjects = {
        enable = false,
        select = {
          enable = false,
        },
        move = {
          enable = false,
        },
      },
    }
  end,
}

return M
