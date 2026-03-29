local M = {
    'sainnhe/gruvbox-material',
    lazy = false,
    --event = "VeryLazy",
    config = function()
        vim.o.background = 'dark'
        vim.g.gruvbox_material_background = "hard"
        vim.g.gruvbox_material_foreground = "original"
        vim.g.gruvbox_material_better_performance = true
        vim.g.gruvbox_material_enable_bold = true
        vim.g.gruvbox_material_enable_italic = true
        vim.g.gruvbox_material_ui_contrast = "high"
        vim.g.gruvbox_material_show_eob = false
        vim.g.gruvbox_material_transparent_background = false
        --vim.g.gruvbox_material_visual = "grey background"
        if vim.o.background == 'dark' then
            vim.g.gruvbox_material_colors_override = {
                bg_dim = { '#1f1f1f', '230' },
                bg0 = { '#1c1c1c', '232' },
            }
        end
        vim.g.gruvbox_material_diagnostic_line_highlight = true
        vim.g.gruvbox_material_diagnostic_virtual_text = 'colored'

        vim.cmd.colorscheme 'gruvbox-material'

        if vim.o.background == 'dark' then
            if vim.g.gruvbox_material_transparent_background then
                vim.api.nvim_set_hl(0, 'CursorLine', { bg = nil })
                vim.api.nvim_set_hl(0, 'StatusLine', { fg = "#e2cca9", bg = "NONE", bold = true })
            end

            vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextError', { fg = "#928374", bold = true, italic = true })
            vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextWarn', { fg = "#928374", bold = true, italic = true })
            vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextInfo', { fg = "#928374", bold = true, italic = true })
            vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextHint', { fg = "#928374", bold = true, italic = true })

            vim.api.nvim_set_hl(0, 'CursorLineNr', { link = "TSCharacterSpecial" })
            vim.api.nvim_set_hl(0, 'TSPunctBracket', { link = 'Grey' })
            vim.api.nvim_set_hl(0, 'TSTagDelimiter', { link = 'Grey' })
            vim.api.nvim_set_hl(0, 'TSTagAttribute', { link = 'TSAttribute' })
            vim.api.nvim_set_hl(0, 'NvimTreeOpenedFile', { fg = '#83a598', bold = true })
            vim.api.nvim_set_hl(0, 'FloatBorder', { fg = '#928374', bold = true })
            vim.api.nvim_set_hl(0, 'NvimTreeCursorLine', { bg = '#2c2c2c' })
            vim.api.nvim_set_hl(0, 'TelescopeSelection', { bg = '#1F1F1F', italic = true })
            vim.api.nvim_set_hl(0, 'TelescopeSelectionCaret', { bg = '#1F1F1F', fg = '#fb4934', bold = true })

            vim.api.nvim_set_hl(0, 'IblIndent', { fg = "#504945" })
            vim.api.nvim_set_hl(0, '@ibl.indent.char.1', { fg = "#504945" })
            vim.api.nvim_set_hl(0, 'IblScope', { fg = '#504945' })
            vim.api.nvim_set_hl(0, '@ibl.scope.char.1', { fg = '#504945' })
        end
    end
}

return M
