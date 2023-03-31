local M = {
    'sainnhe/gruvbox-material',
    lazy = false,
    config = function()
        vim.g.gruvbox_material_background = "hard"
        vim.g.gruvbox_material_foreground = "original"
        vim.g.gruvbox_material_better_performance = true
        vim.g.gruvbox_material_enable_bold = true
        vim.g.gruvbox_material_enable_italic = true
        vim.g.gruvbox_material_ui_contrast = "high"
        vim.g.gruvbox_material_show_eob = false
        vim.g.gruvbox_material_transparent_background = false
        vim.g.gruvbox_material_visual = "grey background"
        vim.g.gruvbox_material_colors_override = {
            --bg_dim = { '#101112', '230' },
            bg0 = { '#1c1c1c', '232' },
        }

        vim.cmd.colorscheme 'gruvbox-material'

        --vim.api.nvim_set_hl(0, 'CursorLine', { bg = nil })
        vim.api.nvim_set_hl(0, 'CursorLineNr', { link = "TSCharacterSpecial" })
        vim.api.nvim_set_hl(0, 'StatusLine', { fg = "#e2cca9", bg = "#282828", bold = true })
        vim.api.nvim_set_hl(0, 'WinBarError', { fg = "#f2594b", italic = true, bold = true })

        vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextError', { fg = "#928374", bold = true, italic = true })
        vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextWarn', { fg = "#928374", bold = true, italic = true })
        vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextInfo', { fg = "#928374", bold = true, italic = true })
        vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextHint', { fg = "#928374", bold = true, italic = true })

        vim.api.nvim_set_hl(0, 'TSPunctBracket', { link = 'Grey' })
        vim.api.nvim_set_hl(0, 'TSTagDelimiter', { link = 'Grey' })
        vim.api.nvim_set_hl(0, 'TSTagAttribute', { link = 'TSAttribute' })
        vim.api.nvim_set_hl(0, 'NvimTreeOpenedFile', { fg = "#83a598", bold = true})
    end
}

return M
