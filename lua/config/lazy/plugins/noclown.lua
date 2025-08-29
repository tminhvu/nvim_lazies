local M = {
  'aktersnurra/no-clown-fiesta.nvim',
  --'https://github.com/tminhvu/no-clown-fiesta.nvim/',
  --dir = '~/Dev/lua/no-clown-fiesta.nvim/',
  --dev = true,
  --event = 'UIEnter',
  lazy = false,
  config = function()
    require("no-clown-fiesta").setup({
      transparent = false,       -- Enable this to disable the bg color
      styles = {
        -- You can set any of the style values specified for `:h nvim_set_hl`
        comments = { italic = true },
        --keywords = { bold = true },
        functions = { bold = true, italic = true },
        variables = {},
        --type = { bold = true },
        --    -- You can set any of the style values specified for `:h nvim_set_hl`
        keywords = {},
        lsp = {},
        match_paren = {},
        type = {},
      },
    })


    vim.cmd.colorscheme 'no-clown-fiesta'


    vim.api.nvim_set_hl(0, 'CursorLine', { bg = '#272727', fg = "NONE" })
    --vim.api.nvim_set_hl(0, 'StatusLine', { bg = '', fg = "#d5d5d5" })
    vim.api.nvim_set_hl(0, 'CursorLineNr', { bg = 'NONE', fg = "#F6D32D" })
    --vim.api.nvim_set_hl(0, 'IndentBlanklineContextChar', { bg = 'NONE', fg = "#151515" })
    --vim.api.nvim_set_hl(0, '@ibl.scope.char.1', { bg = 'NONE', fg = "#727272" })
    --[[
        --local colors = {
  none = "NONE",
  fg = "#D5D5D5",
  bg = "#151515",
  alt_bg = "#171717",
  accent = "#202020",
  white = "#E1E1E1",
  gray = "#373737",
  medium_gray = "#727272",
  light_gray = "#AFAFAF",
  blue = "#A5D6FF",
  gray_blue = "#7E97AB",
  medium_gray_blue = "#A2B5C1",
  cyan = "#88afa2",
  red = "#CC6666",
  green = "#90A959",
  light_green = "#90A959",
  yellow = "#F4BF75",
  orange = "#FFA557",
  purple = "#AA749F",
  pale_purple = "#A5D6FF",
  magenta = "#AA759F",
  cursor_fg = "#D0D0D0",
  cursor_bg = "#151515",
  sign_add = "#90A959",
  sign_change = "#82a8c8",
  sign_delete = "#AC4142",
  error = "#AC4142",
  warning = "#F4BF75",
  info = "#F4BF75",
  hint = "#A5D6FF",
  hint_green = "#90A959",
  neogit_light_green = "#4f5c32",
  neogit_blue = "#33424f",
  neogit_green = "#3f4928",
  neogit_light_red = "#4f2929",
  neogit_red = "#3f2121",
  purple_test = "#ff00ff",
  cyan_test = "#00ffff",
}

return colors
        --]]
  end
}

return M
