local M = {
    'lewis6991/gitsigns.nvim',
    event = 'BufReadPost',
    cond = function()
        return vim.loop.fs_stat(".git")
    end,
    config = function()
        require('gitsigns').setup {
            signs = {},
            --  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
            --  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
            --  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
            --  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
            watch_gitdir = {
                interval = 1000,
                follow_files = false
            },
            current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
                delay = 500,
                ignore_whitespace = false,
            },
            preview_config = {
                -- Options passed to nvim_open_win
                border = 'none',
                relative = 'cursor',
                row = 1,
                col = 1
            },
            current_line_blame_formatter = '    <author>, <author_time:%Y-%m-%d> - <summary>',
        }
    end
}

return M
