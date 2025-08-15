return {
    "HoNamDuong/hybrid.nvim",
    --lazy = false,
    config = function()
        -- Default options:
        require("hybrid").setup({
            terminal_colors = true,
            undercurl = true,
            underline = true,
            bold = true,
            italic = {
                strings = false,
                emphasis = true,
                comments = true,
                folds = true,
            },
            strikethrough = true,
            inverse = true,
            transparent = false,
            overrides = function(highlights, colors)
                 highlights.EndOfBuffer = {
                    fg = '#1d1f21'
                }
                 highlights.WinBar = {
                    bold = false,
                    fg = '#c5c8c6',
                    bg = '#1d1f21'
                }
            end,
        })
        vim.cmd [[ colorscheme hybrid ]]
    end
}
