local M = {
    'LunarVim/onedarker.nvim',
    lazy = true,
    config =  function ()
        vim.cmd.colorscheme 'onedarker'

        vim.api.nvim_set_hl(0, 'WinBar', { bold = true })
        vim.api.nvim_set_hl(0, 'WinBarNC', { link = 'Comment' })
        vim.api.nvim_set_hl(0, 'WinBarError', { link = 'DiagnosticSignError'})

        vim.api.nvim_set_hl(0, 'StatusLine', { fg = '#8b92a8', bg = '#1e222a', bold = true })

        vim.api.nvim_set_hl(0, 'TelescopeMatching', { fg = '#d5b06b', bold = true })
    end
}

return M
