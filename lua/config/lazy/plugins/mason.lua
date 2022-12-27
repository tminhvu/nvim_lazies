return {
    {
        "williamboman/mason.nvim",
        event = 'BufReadPost',
        dependencies = {
            'neovim/nvim-lspconfig',
            "williamboman/mason-lspconfig.nvim",
            'hrsh7th/cmp-nvim-lsp',
        },
        config = function()
            print('hello')
            require("mason").setup()
            local mason_lspconfig = require('mason-lspconfig')

            mason_lspconfig.setup {
                ensure_installed = { "clangd", "jdtls", "bashls", "cssls", "tsserver", "eslint", "html", "astro",
                    "tailwindcss", "jsonls", "marksman", "sumneko_lua" }
            }

            -- LSP SERVER CONFIG
            local opts = { noremap = true, silent = true }
            local on_attach = function(client, bufnr)
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
                vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
                vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
                vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.format { async = true }<CR>',
                    opts)
            end

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require('cmp_nvim_lsp').default_capabilities()

            require("mason-lspconfig").setup_handlers {
                -- The first entry (without a key) will be the default handler
                -- and will be called for each installed server that doesn't have
                -- a dedicated handler.

                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {
                        on_attach = on_attach,
                        capabilities = capabilities,
                        flags = {
                            debounce_text_changes = 150
                        }
                    }
                end,


                ["sumneko_lua"] = function()
                    local function lib()
                        if vim.fn.getcwd() == "~/.config/nvim" then
                            -- Make the server aware of Neovim runtime files
                            -- Make runtime files discoverable to the server
                            return vim.api.nvim_get_runtime_file('', true)
                        end
                        return {}
                    end

                    local function run_path()
                        local runtime_path = vim.split(package.path, ';')
                        table.insert(runtime_path, 'lua/?.lua')
                        table.insert(runtime_path, 'lua/?/init.lua')
                    end

                    require('lspconfig').sumneko_lua.setup {
                        on_attach = on_attach,
                        capabilities = capabilities,
                        debounce_text_changes = 150,
                        settings = {
                            Lua = {
                                runtime = {
                                    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                                    version = 'LuaJIT',
                                    -- Setup your lua path
                                    path = run_path(),
                                },
                                diagnostics = {
                                    -- Get the language server to recognize the `vim` global
                                    globals = { 'vim' },
                                },
                                workspace = {
                                    -- Make the server aware of Neovim runtime files
                                    library = lib(),
                                },
                                -- Do not send telemetry data containing a randomized but unique identifier
                                telemetry = {
                                    enable = false,
                                },
                            },
                        },
                        root_dir = function(fname)
                            return require('lspconfig').util.root_pattern(
                                '.gitignore',
                                'README.md',
                                '.luarc.json',
                                'src',
                                'main.lua',
                                'init.lua',
                                '.git')(fname) or vim.fn.getcwd()
                        end,
                        single_file_support = true
                    }
                end
            }

            -- end config
        end
    },
}
