local M = {
    'metalelf0/jellybeans-nvim',
    lazy = true,
    dependencies = { "rktjmp/lush.nvim" },
    config = function()
        vim.cmd.colorscheme 'jellybeans-nvim'

        vim.api.nvim_set_hl(0, 'DiagnosticUnderlineHint', { link = 'LspDiagnosticsUnderlineHint' })
        vim.api.nvim_set_hl(0, 'DiagnosticUnderlineInfo', { link = 'LspDiagnosticsUnderlineInformation' })
        vim.api.nvim_set_hl(0, 'DiagnosticUnderlineWarn', { link = 'LspDiagnosticsUnderlineWarning' })
        vim.api.nvim_set_hl(0, 'DiagnosticUnderlineError', { link = 'LspDiagnosticsUnderlineError' })

        vim.api.nvim_set_hl(0, 'EndOfBuffer', { fg = '#141414' })
        --vim.api.nvim_set_hl(0, 'NormalFloat', { bg = '#141414' })
        --
        --vim.api.nvim_set_hl(0, 'IblIndent', { fg = "#141414" })
        --vim.api.nvim_set_hl(0, '@ibl.indent.char.1', { fg = "#141414" })
        --vim.api.nvim_set_hl(0, 'IblScope', { fg = '#414141' })
        --vim.api.nvim_set_hl(0, '@ibl.scope.char.1', { fg = '#414141' })
    end
}

return M
