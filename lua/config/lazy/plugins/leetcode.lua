return {
    "kawre/leetcode.nvim",
    --build = ":TSUpdate html", -- if you have `nvim-treesitter` installed
    cmd = "Leet",
    dependencies = {
        -- include a picker of your choice, see picker section for more details
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
    },
    opts = {
        lang = 'c',
        picker = {
            provider = 'fzf-lua',
        },
        injector = {
            ['c'] = {
                imports = function()
                    return {
                        "#include <stdio.h>",
                        "#include <stdbool.h>",
                    }
                end,
                after = "int main() {}"
            }
        }
        --debug = true
        --editor = {
        --    reset_pre
        --}
    },
}
