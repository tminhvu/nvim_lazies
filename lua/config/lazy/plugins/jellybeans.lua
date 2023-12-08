local M = {
    'metalelf0/jellybeans-nvim',
    lazy = false,
    dependencies = { "rktjmp/lush.nvim" },
    config = function()
        vim.cmd.colorscheme 'jellybeans-nvim'
        vim.api.nvim_set_hl(0, 'DiagnosticUnderlineHint', { link = 'LspDiagnosticsUnderlineHint' })
        vim.api.nvim_set_hl(0, 'DiagnosticUnderlineInfo', { link = 'LspDiagnosticsUnderlineInformation' })
        vim.api.nvim_set_hl(0, 'DiagnosticUnderlineWarn', { link = 'LspDiagnosticsUnderlineWarning' })
        vim.api.nvim_set_hl(0, 'DiagnosticUnderlineError', { link = 'LspDiagnosticsUnderlineError' })

        vim.api.nvim_set_hl(0, 'EndOfBuffer', { fg = '#141414' })
    end
}

return M
