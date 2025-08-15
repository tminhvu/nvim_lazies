local M = {
    'nvim-flutter/flutter-tools.nvim',
    lazy = true,
    ft = "dart",
    dependencies = {
        'nvim-lua/plenary.nvim',
        --'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
        --local capabilities = require('cmp_nvim_lsp').default_capabilities()
        local capabilities = require('blink.cmp').get_lsp_capabilities()
        local opts = { noremap = true, silent = true }
        require('flutter-tools').setup({
            decorations = {
                statusline = {
                    -- set to true to be able use the 'flutter_tools_decorations.app_version' in your statusline
                    -- this will show the current version of the flutter app from the pubspec.yaml file
                    app_version = false,
                    -- set to true to be able use the 'flutter_tools_decorations.device' in your statusline
                    -- this will show the currently running device if an application was started with a specific
                    -- device
                    device = false,
                    -- set to true to be able use the 'flutter_tools_decorations.project_config' in your statusline
                    -- this will show the currently selected project configuration
                    project_config = false,
                }
            },
            dev_log = {
                enabled = false,
                filter = nil, -- optional callback to filter the log
                -- takes a log_line as string argument; returns a boolean or nil;
                -- the log_line is only added to the output if the function returns true
                notify_errors = false, -- if there is an error whilst running then notify the user
                open_cmd = "15split", -- command to use to open the log buffer
                focus_on_open = true, -- focus on the newly opened log window
            },
            flutter_path = "/home/mx-vu/Documents/flutter/bin/flutter",
            outline = {
                open_cmd = "35vnew", -- command to use to open the outline buffer
                auto_open = false    -- if true this will open the outline automatically when it is first populated
            },
            closing_tags = {
                highlight = "Comment", -- highlight for the closing tag
                prefix = ">> ",         -- character to use for close tag e.g. > Widget
                enabled = true        -- set to false to disable
            },
            lsp = {
                on_attach = function(client, bufnr)
                    client.server_capabilities.semanticTokensProvider = nil
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
                    --vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
                    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
                    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f',
                        '<cmd>lua vim.lsp.buf.format { async = true }<CR>',
                        opts)
                    --vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
                    --    vim.lsp.handlers.hover, {
                    --        -- Use a sharp border with `FloatBorder` highlights
                    --        --border = "single",
                    --        -- add the title in hover float window
                    --        title = "Document"
                    --    }
                    --)
                    --vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
                    --    vim.lsp.handlers.signature_help, {
                    --        -- Use a sharp border with `FloatBorder` highlights
                    --        --border = "single",
                    --        title = "Signature"
                    --    }
                    --)
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
                    lineLength = 80,
                    showTodos = true,
                    completeFunctionCalls = true,
                    --analysisExcludedFolders = { "<path-to-flutter-sdk-packages>" },
                    renameFilesWithClasses = "ask", -- "always"
                    --enableSnippets = true,
                    analysisExcludedFolders = { "~/.pub-cache" },
                    enableSnippets = true,
                    updateImportsOnRename = true,
                }
            }
        })
    end
}

return M
