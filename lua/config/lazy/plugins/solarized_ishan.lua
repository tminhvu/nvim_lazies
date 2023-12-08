local M = {
    'ishan9299/nvim-solarized-lua',
    lazy = true,
    config = function()
        vim.g.solarized_italics = 1
        vim.g.solarized_visibility = 'low'
        vim.g.solarized_diffmode = 'low'
        vim.g.solarized_statusline = 'flat'
        vim.g.solarized_termtrans = 0

        vim.cmd.colorscheme 'solarized'

        vim.api.nvim_set_hl(0, 'EndOfBuffer', { fg = "#002B36" })
        vim.api.nvim_set_hl(0, '@parameter', { fg = "#93a1a1" })
        vim.api.nvim_set_hl(0, '@punctuation.bracket', { link = '@text' })

        vim.api.nvim_set_hl(0, 'DiagnosticUnderlineInfo', { sp = "#2aa198", undercurl = true, })
        vim.api.nvim_set_hl(0, 'DiagnosticUnderlineHint', { sp = "#859900", undercurl = true, })
        vim.api.nvim_set_hl(0, 'DiagnosticUnderlineWarn', { sp = "#b58900", undercurl = true, })
        vim.api.nvim_set_hl(0, 'DiagnosticUnderlineError', { sp = "#dc322f", undercurl = true, })

        vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextError', { link = 'Comment' })
        vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextWarn', { link = 'Comment' })
        vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextInfo', { link = 'Comment' })
        vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextHint', { link = 'Comment' })

        vim.api.nvim_set_hl(0, 'Visual', { bg = '#073642' })
    end
}

return M
