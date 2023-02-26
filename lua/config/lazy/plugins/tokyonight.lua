local M = {
    'folke/tokyonight.nvim',
    lazy = false,
    config = function()
        require("tokyonight").setup({
            -- your configuration comes here
            -- or leave it empty to use the default settings
            style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
            light_style = "day", -- The theme is used when the background is set to light
            transparent = false, -- Enable this to disable setting the background color
            terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
            styles = {
                -- Style to be applied to different syntax groups
                -- Value is any valid attr-list value for `:help nvim_set_hl`
                comments = { italic = true },
                keywords = { italic = true, bold = true },
                functions = { bold = true },
                variables = {},
                -- Background styles. Can be "dark", "transparent" or "normal"
                sidebars = "dark", -- style for sidebars, see below
                floats = "dark", -- style for floating windows
            },
            sidebars = { "nvimtree", "help", "terminal", "Outline" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
            day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
            hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
            dim_inactive = false, -- dims inactive windows
            lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold
            on_highlights = function(hl, c)
                hl.WinBar = {
                    bold = true
                }
                hl.WinBarNC = {
                    fg = c.fg_dark,
                    bg = c.bg_dark,
                    bold = false
                }
                hl.WinBarError = {
                    fg = c.red,
                    bold = true,
                    italic = true
                }
                hl.StatusLine = {
                    bg = c.bg,
                    bold = true
                }
                hl.NvimTreeOpenedFile = {
                    fg = c.orange
                }

                -- Telescope
                local prompt = "#2d3149"
                hl.TelescopeNormal = {
                    bg = c.bg_dark,
                }
                hl.TelescopeBorder = {
                    bg = c.bg_dark,
                    fg = c.bg_dark,
                }
                hl.TelescopePromptNormal = {
                    bg = prompt,
                }
                hl.TelescopePromptBorder = {
                    bg = prompt,
                    fg = prompt,
                }
                hl.TelescopePromptTitle = {
                    bg = prompt,
                    fg = c.fg,
                    bold = true
                }
                hl.TelescopePreviewTitle = {
                    bg = c.bg_dark,
                    fg = c.bg_dark,
                }
                hl.TelescopeResultsTitle = {
                    bg = c.bg_dark,
                    fg = c.bg_dark,
                }
            end,
        })

        vim.cmd.colorscheme "tokyonight"
        --vim.api.nvim_set_hl(0, 'WinBar', { bold = true })
        --vim.api.nvim_set_hl(0, 'WinBarError', { fg = "#db4b4b", bold = true, italic = true })
        --vim.api.nvim_set_hl(0, 'StatusLine', { bg = "#1f2231", bold = true })
        --vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextError', { link = "NonText" })
        --vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextWarn', { link = "NonText" })
        --vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextInfo', { link = "NonText" })
        --vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextHint', { link = "NonText" })
    end
}

return M
