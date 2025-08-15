return {
    "tminhvu/arctic.nvim",
    --dev = true,
    --dir = '~/Dev/lua/arctic.nvim/',
    dependencies = { "rktjmp/lush.nvim" },
    lazy = false,
    event = "VeryLazy",
    --branch = "v2",
    config = function()
        vim.cmd("colorscheme arctic")
    end
}
