local M = {
    "Dhanus3133/LeetBuddy.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
    },
    config = function()
        require("leetbuddy").setup({
            language = "dart",
        })
    end,
    keys = {
        { "<leader>lcq", "<cmd>LBQuestions<cr>", desc = "List Questions" },
        { "<leader>lcl", "<cmd>LBQuestion<cr>",  desc = "View Question" },
        { "<leader>lcr", "<cmd>LBReset<cr>",     desc = "Reset Code" },
        { "<leader>lct", "<cmd>LBTest<cr>",      desc = "Run Code" },
        { "<leader>lcs", "<cmd>LBSubmit<cr>",    desc = "Submit Code" },
    },
}

return M
