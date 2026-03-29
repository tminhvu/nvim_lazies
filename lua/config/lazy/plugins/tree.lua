local M = {
  'nvim-treesitter/nvim-treesitter',
  event = 'UIEnter',
  --lazy = false,
  branch = 'master',
  --build = ':TSUpdate',
  dependencies = {
    'windwp/nvim-ts-autotag',
    'nvim-treesitter/playground'
  },
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
      autotag = {
        enable = false,
      },
      playground = {
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
