local M = {
    'kyazdani42/nvim-web-devicons',
    lazy = true,
    config = function()
        require 'nvim-web-devicons'.setup {
            default = true;
            override = {
                txt = {
                    icon = "",
                    color = "#428850",
                    cterm_color = "65",
                    name = "Text"
                };
            }
        }

        --require('config.statusline-winbar').icon = true
    end
}
return M
