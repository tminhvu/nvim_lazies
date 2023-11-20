local M = {
    'akinsho/bufferline.nvim',
    event = 'BufReadPost',
    version = "*",
    config = function()
        require("bufferline").setup {
            options = {
                offsets = {
                    {
                        filetype = "NvimTree",
                        text = "  Files",
                        separator = true,
                        text_align = "left"
                    }
                },
                diagnostics = "nvim_lsp",
            },
        }
    end
}
return M
