return {
    "mason-org/mason-lspconfig.nvim",
    --lazy = false,
    event = "BufReadPost",
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
        'saghen/blink.cmp',
    },
    config = function()
        require('mason-lspconfig').setup({
            ensure_installed = { "clangd", "bashls", "cssls", "ts_ls", "eslint", "html",
                "tailwindcss", "jsonls", "marksman", "lua_ls" },
            automatic_enable = false,
        })

        local on_attach = function(client, bufnr)
            local opts = { noremap = true, silent = true }
            --client.server_capabilities.semanticTokensProvider = nil
            -- See `:help vim.lsp.*` for documentation on any of the below functions
            vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
            vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
            vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>',
                opts)
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr',
                '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl',
                '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
            vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
            --vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.format { async = true }<CR>',
                opts)
            --vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
            --    vim.lsp.handlers.hover, {
            --        -- Use a sharp border with `FloatBorder` highlights
            --        --border = "single",
            --        -- add the title in hover float window
            --        --border = 'none',
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
        end

        local capabilities = require('blink.cmp').get_lsp_capabilities()
        local lspconfig = require('lspconfig')

        lspconfig['clangd'].setup {
            on_attach = on_attach,
            capabilities = capabilities,
            flags = {
                debounce_text_changes = 150,
            },
            root_dir = function(fname)
                return lspconfig.util.root_pattern(
                    'src',
                    '.clangd',
                    'README.md',
                    '.clang-tidy',
                    --'.clang-format',
                    'compile_commands.json',
                    'compile_flags.txt',
                    'configure.ac')(fname) or vim.fn.getcwd()
            end
        }

        lspconfig['tailwindcss'].setup {
            autostart = false,
            on_attach = on_attach,
            capabilities = capabilities,
            flags = {
                debounce_text_changes = 150
            }
        }

        lspconfig['eslint'].setup({
            autostart = false,
            on_attach = on_attach,
            capabilities = capabilities,
            flags = {
                debounce_text_changes = 150
            }
        })

        lspconfig['marksman'].setup {
            on_attach = on_attach,
            capabilities = capabilities,
            flags = {
                debounce_text_changes = 150,
            },
            root_dir = function(fname)
                return lspconfig.util.root_pattern(
                    'index.md',
                    'README.md')(fname) or vim.fn.getcwd()
            end,
            single_file_support = true
        }

        lspconfig['lua_ls'].setup {
            on_attach = on_attach,
            capabilities = capabilities,
            flags = {
                debounce_text_changes = 150,
            },
            settings = {
                Lua = {
                    runtime = {
                        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                        version = 'LuaJIT',
                    },
                    diagnostics = {
                        -- Get the language server to recognize the `vim` global
                        globals = { 'vim' },
                    },
                    workspace = {
                        -- Make the server aware of Neovim runtime files
                        --library = lib()
                        library = vim.api.nvim_get_runtime_file("", true),
                    },
                    -- Do not send telemetry data containing a randomized but unique identifier
                    telemetry = {
                        enable = false,
                    },
                },
            },
            root_dir = function(fname)
                return lspconfig.util.root_pattern(
                    'README.md',
                    '.luarc.json',
                    '.gitignore',
                    '.git',
                    'main.lua',
                    'src')(fname) or vim.fn.getcwd()
            end,
        }

        local lsps = { "bashls", "cssls", "ts_ls", "html", "astro", "jsonls" }
        for i = 1, #lsps, 1 do
            lspconfig[lsps[i]].setup {
                on_attach = on_attach,
                capabilities = capabilities,
                flags = {
                    debounce_text_changes = 150
                },
            }
        end


        --["jdtls"] = function()
        --    lspconfig.jdtls.setup {
        --        on_attach = on_attach,
        --        capabilities = capabilities,
        --        root_dir = function(fname)
        --            return lspconfig.util.root_pattern(
        --                'src',
        --                'build.xml',
        --                'pom.xml',
        --                'settings.gradle',
        --                'settings.gradle.kts',
        --                'README.md',
        --                '.git')(fname) or vim.fn.getcwd()
        --        end,
        --        filetypes = { "java" },
        --        single_file_support = true,
        --        settings = {
        --            java = {
        --                completion = {
        --                    overwrite = true
        --                }
        --            }
        --        },
        --    }
        --end

        --["astro"] = function()
        --    lspconfig.astro.setup({
        --        autostart = false,
        --        on_attach = on_attach,
        --        capabilities = capabilities,
        --        flags = {
        --            debounce_text_changes = 150
        --        }
        --    })
        --end,
    end
}
