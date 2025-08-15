local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--single-branch",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
end
vim.opt.runtimepath:prepend(lazypath)

require('lazy').setup('config.lazy.plugins', {
    rocks = { enabled = false },
    defaults = {
        lazy = true, -- should plugins be lazy-loaded?
    },
    dev = {
        path = "~/Dev/lua",
        patterns = {}, -- For example {"folke"}
    },
    ui = {
        custom_keys = {
            -- open lazygit log
            ["<localleader>l"] = false,
            -- open a terminal for the plugin dir
            ["<localleader>t"] = false
        },
    },
    change_detection = {
        -- automatically check for config file changes and reload the ui
        enabled = false,
        notify = false, -- get a notification when changes are found
    },
    performance = {
        rtp = {
            disabled_plugins = {
                -- "matchparen",
                "netrwPlugin",
                "netrwSettings",
                "netrwFileHandlers",
                "gzip",
                "zip",
                "zipPlugin",
                "tar",
                "tarPlugin",
                "getscript",
                "getscriptPlugin",
                "vimball",
                "vimballPlugin",
                "2html_plugin",
                "logipat",
                "rrhelper",
                "spellfile_plugin",
                "matchit",
                "rplugin",
                "shada",
                "spellfile",
                "tohtml",
                "tutor"
            },
        },
    },
})
