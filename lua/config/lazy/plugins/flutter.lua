local M = {
    'akinsho/flutter-tools.nvim',
    lazy = true,
    ft = "dart",
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        require('flutter-tools').setup({
            flutter_path = "/home/mx-vu/Src/flutter/bin/flutter",
            lsp = {
                on_attach = function(_, bufnr)
                    local opts = { noremap = true, silent = true }
                    -- See `:help vim.lsp.*` for documentation on any of the below functions
                    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
                    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
                    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
                    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa',
                        '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>',
                        opts)
                    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr',
                        '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
                    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl',
                        '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
                    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
                    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
                    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
                    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
                    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f',
                        '<cmd>lua vim.lsp.buf.format { async = true }<CR>',
                        opts)
                end,
                capabilities = capabilities
            }
        })
    end
}

return M
