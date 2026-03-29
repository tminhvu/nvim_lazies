local M = {
  'folke/tokyonight.nvim',
  lazy = true,
  config = function()
    require("tokyonight").setup({
      style = "night",        -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
      light_style = "day",    -- The theme is used when the background is set to light
      transparent = false,    -- Enable this to disable setting the background color
      terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
      styles = {
        comments = { italic = true },
        keywords = {},
        functions = { italic = true },
        variables = {},
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = "dark", -- style for sidebars, see below
        floats = "dark",   -- style for floating windows
      },
      sidebars = { "nvimtree", "help", "terminal", "Outline" },
      day_brightness = 0.2, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
      hide_inactive_statusline = false,
      dim_inactive = false,
      lualine_bold = true,
      use_background = true,
      on_highlights = function(hl, c)
        --  hl.IndentBlanklineContextChar = {
        --      fg = c.dark5,
        --  }
        --  hl.TSConstructor = {
        --      fg = c.blue1,
        --  }
        --  hl.TSTagDelimiter = {
        --      fg = c.dark5,
        --  }
        --
        --hl.IblIndent = {
        --    fg = c.bg
        --}
        --hl.IblScope = {
        --    fg = c.bg
        --}
        --hl.WinBar = {
        --    bold = true
        --}
        --   hl.StatusLine = {
        --       bg = c.bg,
        --       bold = true
        --   }
        hl.NvimTreeOpenedFile = {
          fg = c.orange
        }

        --Telescope
      end,
    })

    vim.cmd.colorscheme "tokyonight"
  end
}

return M
