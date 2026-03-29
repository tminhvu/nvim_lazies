local M = {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    --lazy = true,
    dependencies = {
      "hrsh7th/cmp-buffer",
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'onsails/lspkind.nvim',
      'saadparwaiz1/cmp_luasnip',
      'L3MON4D3/LuaSnip',
    },
    config = function()
      local luasnip = require 'luasnip'
      require("luasnip/loaders/from_vscode").lazy_load { paths = { "~/.config/nvim/snippets" } }

      local cmp = require('cmp')
      local lspkind = require('lspkind')

      lspkind.init({
        symbol_map = {
          Array         = " ",
          Boolean       = "󰨙 ",
          Class         = " ",
          Codeium       = "󰘦 ",
          Color         = " ",
          Control       = " ",
          Collapsed     = " ",
          Constant      = "󰏿 ",
          Constructor   = " ",
          Copilot       = " ",
          Enum          = " ",
          EnumMember    = " ",
          Event         = " ",
          Field         = " ",
          File          = " ",
          Folder        = " ",
          Function      = "󰊕 ",
          Interface     = " ",
          Key           = " ",
          Keyword       = " ",
          Method        = "󰊕 ",
          Module        = " ",
          Namespace     = "󰦮 ",
          Null          = " ",
          Number        = "󰎠 ",
          Object        = " ",
          Operator      = " ",
          Package       = " ",
          Property      = " ",
          Reference     = " ",
          Snippet       = " ",
          String        = " ",
          Struct        = "󰆼 ",
          TabNine       = "󰏚 ",
          Text          = " ",
          TypeParameter = " ",
          Unit          = " ",
          Value         = " ",
          Variable      = "󰀫 ",
        },
      })

      local compare = cmp.config.compare

      compare.locality.lines_count = 300

      -- nvim-cmp setup
      cmp.setup {
        --    view = {
        --        entries = { name = 'custom', selection_order = 'near_cursor' }
        --    },
        performance = {
          debounce = 20,
          throttle = 10,
        },
        sorting = {
          priority_weight = 1.0,
          comparators = {
            --compare.kind,
            compare.score,
            --compare.locality,
            --compare.exact,
            --compare.recently_used,
            compare.offset,
            --compare.length,
            --compare.order,
            --cmp.config.compare.length,
            --cmp.config.compare.score,
            --cmp.config.compare.locality,
            --cmp.config.compare.order,
            --cmp.config.compare.kind,
            --cmp.config.compare.recently_used,
            --cmp.config.compare.offset,
            --cmp.config.compare.exact,
            --cmp.config.compare.sort_text,
          },
        },
        matching = {
          disallow_fuzzy_matching = false,
          disallow_fullfuzzy_matching = true,
          disallow_partial_fuzzy_matching = true,
          disallow_partial_matching = false,
          disallow_prefix_unmatching = true,
        },
        formatting = {
          format = lspkind.cmp_format({
            maxwidth = 40,
            mode = "symbol_text",
            ellipsis_char = '...',
            menu = ({
              nvim_lsp = "[L]",
              luasnip = "[S]",
              buffer = "[B]",
              path = "[P]"
            })
          }),
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          --['<CR>'] = cmp.complete(),
          ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
          },
          ['<Tab>'] = cmp.mapping(function(fallback)
            -- if luasnip.expand_or_locally_jumpable() then
            --     luasnip.expand_or_jump()
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            -- if luasnip.jumpable(-1) then
            --     luasnip.jump(-1)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<C-l>'] = cmp.mapping(function(fallback)
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<C-j>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<C-k>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp', max_item_count = 15 },
          { name = 'luasnip',  max_item_count = 5 },
          { name = 'path',     max_item_count = 5 },
          { name = 'buffer',   max_item_count = 5 }
        }),
      }

      -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'cmdline' },
          --{ name = 'buffer' },
        }
      })
    end
  }
}

return M
