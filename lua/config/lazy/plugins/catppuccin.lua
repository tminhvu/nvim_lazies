local M = {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    config = function()
        require("catppuccin").setup({
            flavour = "mocha", -- Can be one of: latte, frappe, macchiato, mocha
            --transparent_background = false,
            term_colors = true,
            styles = {
                comments = { "italic" },
                properties = {},
                functions = { "bold" },
                keywords = { "bold" },
                operators = { "bold" },
                conditionals = { "bold" },
                loops = { "bold" },
                booleans = { "bold" },
                numbers = {},
                types = { 'bold' },
                strings = {},
                variables = {},
            },
            integrations = {
                treesitter = true,
                native_lsp = {
                    enabled = true,
                    virtual_text = {
                        errors = { "italic", "bold" },
                        hints = { "italic", "bold" },
                        warnings = { "italic", "bold" },
                        information = { "italic", "bold" },
                    },
                    underlines = {
                        errors = { "undercurl" },
                        hints = { "undercurl" },
                        warnings = { "undercurl" },
                        information = { "undercurl" },
                    },
                },
                lsp_trouble = false,
                lsp_saga = false,
                gitgutter = false,
                gitsigns = true,
                telescope = true,
                nvimtree = true,
                which_key = false,
                indent_blankline = { enabled = true, colored_indent_levels = false },
                dashboard = false,
                neogit = false,
                vim_sneak = false,
                fern = false,
                barbar = false,
                markdown = true,
                lightspeed = false,
                ts_rainbow = true,
                mason = false,
                neotest = false,
                noice = false,
                hop = false,
                illuminate = false,
                cmp = true,
                dap = { enabled = false, enable_ui = false },
                notify = false,
                symbols_outline = false,
                coc_nvim = false,
                leap = false,
                neotree = { enabled = false, show_root = true, transparent_panel = false },
                telekasten = false,
                mini = false,
                aerial = false,
                vimwiki = true,
                beacon = false,
                navic = { enabled = false },
                overseer = false,
                fidget = false,
            },
            color_overrides = {
                mocha = {
                },
            },
            highlight_overrides = {
                mocha = function(cp)
                    return {
                        -- For base configs.
                        WinBar = { bg = cp.none, fg = cp.teal, style = { 'bold' } },
                        WinBarNC = { bg = cp.none, fg = cp.overlay1 },
                        WinBarError = { bg = cp.none, fg = cp.red, style = { 'bold', 'italic' } },
                        StatusLine = { fg = cp.mantle, bg = cp.overlay0, style = { 'bold' } },
                        NvimTreeOpenedFile = { fg = cp.green, style = { 'bold' } },

                        -- For native lsp configs.
                        DiagnosticVirtualTextError = { bg = cp.none, fg = cp.surface2 },
                        DiagnosticVirtualTextWarn = { bg = cp.none, fg = cp.surface2 },
                        DiagnosticVirtualTextInfo = { bg = cp.none, fg = cp.surface2 },
                        DiagnosticVirtualTextHint = { bg = cp.none, fg = cp.surface2 },

                        DiagnosticHint = { style = { 'bold' } },
                        DiagnosticWarn = { style = { 'bold' } },
                        DiagnosticError = { style = { 'bold' } },
                        DiagnosticInfo = { style = { 'bold' } },
                        DiagnosticSignHint = { style = { 'bold' } },
                        DiagnosticSignWarn = { style = { 'bold' } },
                        DiagnosticSignError = { style = { 'bold' } },
                        DiagnosticSignInfo = { style = { 'bold' } },
                    }
                end,
            },
        })

        -- setup must be called before loading
        vim.cmd.colorscheme "catppuccin"
    end
}

return M
