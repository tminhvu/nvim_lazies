local M = {
    'cpea2506/one_monokai.nvim',
    lazy = true,
    config = function()
        require('one_monokai').setup({
            transparent = false,
            colors = {
                bg = '#18191a',
                --bg = '#1F2329',
                cline = "#282c34",
            },
            themes = function(colors)
                return {
                    StatusLine = { bold = true },
                    CursorLine = { bg = colors.cline },
                    EndOfBuffer = { fg = colors.bg },
                    VertSplit = { fg = colors.dark_gray },
                    WinBar = { fg = colors.cyan, bold = true },
                    WinBarNC = { fg = colors.light_gray, bold = false, italic = true },
                    WinBarError = { fg = colors.pink, bold = true, italic = true },
                    IndentBlanklineChar = { fg = colors.vulcan },
                    ['@punctuation.bracket'] = { fg = colors.gray },
                    DiagnosticUnderlineError = { sp = colors.red, undercurl = true },
                    DiagnosticUnderlineHint = { sp = colors.light_gray, undercurl = true },
                    DiagnosticUnderlineInfo = { sp = colors.green, undercurl = true },
                    DiagnosticUnderlineWarn = { sp = colors.yellow, undercurl = true },
                    GitSignsCurrentLineBlame = { fg = colors.light_gray },
                    TelescopeSelection = { link = 'CursorLine' },
                    TelescopeMatching = { fg = colors.yellow },
                    Pmenu = { fg = colors.fg, bg = colors.dark_blue },
                    NvimTreeNormal = { fg = colors.fg, bg = colors.black },
                    NvimTreeIndentMarker = { fg = colors.vulcan }
                }
            end
            -- colors = {
            -- green = "#00ff00",
            -- blue = "#0000ff",
            -- roman = "#e36965",
            -- lmao = "#282c34",
            -- },
            -- themes = function(colors)
            -- return {
            -- Normal = { bg = colors.lmao },
            -- Comment = { fg = colors.pink, italic = true },
            -- ErrorMsg = { fg = "black", bg = "#ec6075", standout = true },
            -- NormalFloat = { link = "Normal" },
            --    fg = "#abb2bf",
            --    bg = "#282c34",
            --    gray = "#676e7b",
            --    pink = "#e06c75",
            --    green = "#98c379",
            --    cyan = "#56b6c2",
            --    aqua = "#61afef",
            --    yellow = "#e5c07b",
            --    purple = "#c678dd",
            --    peanut = "#f6d5a4",
            --    orange = "#d19a66",
            --    dark_pink = "#ff008c",
            --    dark_cyan = "#2b8db3",
            --    red = "#f75f5f",
            --    dark_red = "#d03770",
            --    white = "#d7d7ff",
            --    light_gray = "#9ca3b2",
            --    dark_gray = "#4b5261",
            --    vulcan = "#383a3e",
            --    dark_green = "#2d2e27",
            --    dark_blue = "#26292f",
            --    black = "#1e2024",
            --    none = "NONE",
        })
        --vim.cmd.colorscheme 'one_monokai'
    end
}
return M
