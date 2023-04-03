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
            outline = {
                open_cmd = "35vnew", -- command to use to open the outline buffer
                auto_open = false -- if true this will open the outline automatically when it is first populated
            },
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
                color = { -- show the derived colours for dart variables
                    enabled = true, -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
                    background = true, -- highlight the background
                    background_color = { r = 19, g = 17, b = 24 }, -- required, when background is transparent (i.e. background_color = { r = 19, g = 17, b = 24},)
                    foreground = false, -- highlight the foreground
                    virtual_text = false, -- show the highlight using virtual text
                    virtual_text_str = "", -- the virtual text character to highlight
                },
                capabilities = capabilities,
                settings = {
                    showTodos = true,
                    completeFunctionCalls = true,
                    --analysisExcludedFolders = { "<path-to-flutter-sdk-packages>" },
                    --renameFilesWithClasses = "prompt", -- "always"
                    enableSnippets = false,
                }
            }
        })
    end
}

return M
