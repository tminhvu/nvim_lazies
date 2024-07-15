return {
    "slugbyte/lackluster.nvim",
    lazy = false,
    init = function()
        local lackluster = require("lackluster")
        local color = lackluster.color

        vim.api.nvim_create_autocmd({ "BufEnter" }, {
            pattern = "*",
            callback = function()
                local devi_ok, devicon = pcall(require, 'nvim-web-devicons')

                if not devi_ok then
                    return
                end

                local filename = vim.fn.expand("%:t")
                local ext = vim.fn.expand("%:e")

                local _, icon_name = devicon.get_icon(filename, ext, { default = true })

                if not icon_name then
                    return
                end

                vim.api.nvim_set_hl(0, 'BufferLine' .. icon_name, { bg = color.gray2, fg = color.gray6 })
                vim.api.nvim_set_hl(0, 'BufferLine' .. icon_name .. 'Selected', { bg = color.gray2, fg = color.lack })
                vim.api.nvim_set_hl(0, 'BufferLine' .. icon_name .. 'Inactive', { bg = color.gray2, fg = color.gray6 })
            end,
        })
        -- vim.cmd.colorscheme("lackluster-hack") -- my favorite
        --
        -- vim.cmd.colorscheme("lackluster-mint")
        vim.cmd.colorscheme("lackluster")

        vim.api.nvim_set_hl(0, 'Visual', { bg = color.gray3 })
        vim.api.nvim_set_hl(0, 'BufferLineBufferSelected', { bg = color.gray2 })
        vim.api.nvim_set_hl(0, 'BufferLineCloseButtonSelected', { bg = color.gray2 })
        vim.api.nvim_set_hl(0, 'BufferLineIndicatorSelected', { bg = color.gray2 })
        vim.api.nvim_set_hl(0, 'BufferLineModifiedSelected', { bg = color.gray2, fg = color.orange })
    end,
}
