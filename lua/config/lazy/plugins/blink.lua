return {
    'saghen/blink.cmp',
    lazy = true,
    version = '*',
    dependencies = {
        'L3MON4D3/LuaSnip',
        version = 'v2.*',
        lazy = true,
        dependencies = {
            'rafamadriz/friendly-snippets',
            config = function()
                require('luasnip.loaders.from_vscode').lazy_load()
                require('luasnip.loaders.from_vscode').lazy_load({ paths = { vim.fn.stdpath 'config' .. '/snippets' } })
            end,
        },
        opts = { history = true, delete_check_events = 'TextChanged' },
    },
    opts = {
        snippets = { preset = 'luasnip' },
        fuzzy = {
            sorts = {
                'exact',
                -- defaults
                'score',
                'sort_text',
            },
            implementation = 'prefer_rust',
        },
        keymap = {
            preset = 'default',
            ['<Tab>'] = {
                function(cmp)
                    if cmp.is_visible() then
                        return cmp.select_next()
                    end
                end,
                --'select_next',
                'fallback'
            },
            ['<S-Tab>'] = { 'select_prev', 'fallback' },
            ['<C-j>'] = { 'select_next', 'fallback' },
            ['<C-k>'] = { 'select_prev', 'fallback' },
            ['<C-l>'] = { 'snippet_forward', 'fallback' },
            ['<C-h>'] = { 'snippet_backward', 'fallback' },
            ['<CR>'] = {
                'accept',
                'fallback'
            },

            --['<Tab>'] = {
            --  function(cmp)
            --    if cmp.snippet_active() then return cmp.accept()
            --    else return cmp.select_and_accept() end
            --  end,
            --  'snippet_forward',
            --  'fallback'
            --},
            --show = '<C-space>',
            --hide = '<C-e>',
            --accept = '<Tab>',
            --select_prev = {},
            --select_next = { '<S-Tab>', '<Down>', '<C-j>' },
            --
            --show_documentation = {},
            --hide_documentation = {},
            --scroll_documentation_up = '<C-b>',
            --scroll_documentation_down = '<C-f>',
        },
        sources = {
              default = { 'lsp', 'snippets', 'path', 'buffer' },
            --default = function(ctx)
            --    local success, node = pcall(vim.treesitter.get_node)
            --    if success and node and vim.tbl_contains({ 'comment', 'line_comment', 'block_comment' }, node:type()) then
            --        return { 'buffer' }
            --    else
            --        return { 'lsp', 'path', 'snippets', 'buffer' }
            --    end
            --end
        },
        signature = { enabled = true },
        cmdline = {
            enabled = false,
        },
        completion = {
            ghost_text = {
                enabled = false,
            },
            list = {
                max_items = 30,
                selection = {
                    preselect = function(ctx)
                        return false
                    end,
                    auto_insert = function(ctx)
                        return true;
                    end
                }
            },
            menu = {
                border = 'single',
                auto_show = true,
                draw = {
                    gap = 2,
                    treesitter = { 'lsp' },
                    columns = {
                        { 'kind_icon' },
                        { 'label',      'label_description', gap = 1 },
                        { 'kind' },
                        { 'source_name' }
                    },
                    components = {
                        source_name = {
                            width = { max = 3 },
                            text = function(ctx) return string.sub(ctx.source_name, 1, 3) end,
                            highlight = 'BlinkCmpSource',
                        },
                    }
                }
            },
            documentation = {
                auto_show = true,
                window = {
                    border = 'single',
                }
            }
        },
    }
}
