local M = {
    'akinsho/bufferline.nvim',
    --event = 'UIEnter',
    version = "*",
    config = function()
        local cwd = vim.fn.getcwd()

        local start = string.find(cwd, '/home/')
        local path = cwd

        if start ~= nil then
            path = '~/' .. string.sub(cwd, start + 12)
        end

        require("bufferline").setup {
            options = {
                offsets = {
                    {
                        filetype = "NvimTree",
                        --text = "  Files",
                        text = path,
                        separator = false,
                        text_align = "left",
                        highlight = "Comment"
                    }
                },
                color_icons = true,
            },
        }
    end
}
return M
