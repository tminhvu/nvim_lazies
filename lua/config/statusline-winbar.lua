local M = {}
M.icon = false

local init_group = vim.api.nvim_create_augroup('reset_group', {
    clear = false,
})

vim.api.nvim_create_autocmd({ 'VimEnter' }, {
    callback = function()
        -- GIT
        -- always runs in the current directory, rather than in the buffer's directory

        if vim.fn.isdirectory('.git') == 0 then
            vim.g.branch_name = ' local'
            return
        end

        local url = vim.fn.system "git config --get remote.origin.url"
        local branch = vim.fn.system "git branch --show-current"

        branch = string.sub(branch, 1, #branch - 1)

        local e = string.find(url, ".git", 20, true)

        if e ~= nil then
            url = string.sub(url, 20, e - 1)
        else
            url = string.sub(url, 20, #url - 1)
        end

        --local branch = vim.fn.system "git branch --show-current | tr -d '\n'"

        if string.len(branch) == 0 then
            vim.g.branch_name = ' HEAD (detatched)'
        else
            vim.g.branch_name = ' ' .. url .. '   ' .. branch -- 
        end
        --             ⎇ ⓢ ⓤ ⓔ ⓝ          
        -- DIR
        -- vim.b.cur_dir = vim.fn.getcwd()
    end,
})

vim.api.nvim_create_autocmd({ 'TermEnter' }, {
    callback = function()
        vim.opt_local.winbar = '   Terminal '
        vim.opt_local.number = false
        --      
    end,
    group = init_group
})

vim.api.nvim_create_autocmd({ 'BufEnter' }, {
    callback = function()
        local filetype = vim.bo.filetype

        -- File icon
        if M.icon then
            -- local file_icon_color
            vim.b.file_icon, _ = require("nvim-web-devicons").get_icon_by_filetype(filetype,
                { default = true })
            --vim.b.file_icon_color = '%#' .. file_icon_color .. '#'
        else
            vim.b.file_icon = ''
        end


        if filetype == 'NvimTree' then
            vim.opt_local.winbar = '   NVIMTREE'
            --          
        end
    end,
    group = init_group
})

vim.api.nvim_create_autocmd({ 'LspAttach' }, {
    callback = function()
        local lsp = vim.lsp.get_active_clients()
        local names = ''

        if lsp ~= nil then
            for l = 1, #lsp do
                --names = names .. '  ' .. lsp[l].name
                names = names .. lsp[l].name .. ' '
            end
        end

        vim.b.lsp_server = ' ' .. names
    end,
    group = init_group
})

vim.api.nvim_create_autocmd({ 'BufEnter', 'FocusGained', 'InsertLeave', 'CursorHold' }, {
    callback = function()
        -- ERROR
        local num_errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
        if num_errors > 0 then
            --vim.b.errors = '   ' .. num_errors
            vim.b.errors = num_errors .. 'E '
            vim.b.winbar_color = '%#WinBarError#'
        else
            vim.b.errors = ''
            vim.b.winbar_color = ''
        end

        -- WARNING
        local num_warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
        if num_warnings > 0 then
            --vim.b.warnings = '   ' .. num_warnings
            vim.b.warnings = num_warnings .. 'W '
        else
            vim.b.warnings = ''
        end

        -- HINT
        local num_hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
        if num_hints > 0 then
            vim.b.hints = num_hints .. 'H '
            --vim.b.hints = '   ' .. num_hints
        else
            vim.b.hints = ''
        end

        -- INFO
        local num_infos = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
        if num_infos > 0 then
            vim.b.infos = num_infos .. 'I '
            --vim.b.infos = '   ' .. num_infos
        else
            vim.b.infos = ''
        end

    end,
    group = init_group,
})

vim.opt.laststatus = 3 -- use global statusline

--vim.opt.winbar = [[ %{%get(b:, "file_icon_color", "")%}%{get(b:, "file_icon", "")}%{%get(b:, "winbar_color", "")%} %t %M%h%w%r ]]
vim.opt.winbar = [[ %{%get(b:, "winbar_color", "")%}%{get(b:, "file_icon", "")} %f %M%h%w%r ]]

--vim.opt.statusline = [[%#StatusLine# %{get(g:, "branch_name", "")} %{get(b:, "lsp_server", "")}%{get(b:, "errors", "")}%{get(b:, "warnings", "")}%{get(b:, "hints", "")}%{get(b:, "infos", "")}%=  %c [%{get(b:, "file_icon", "")} %Y]  %l/%L ]]

vim.opt.statusline = '  %{get(g:, "branch_name", "")}  %{get(b:, "lsp_server", "")} %{get(b:, "errors", "")}%{get(b:, "warnings", "")}%{get(b:, "hints", "")}%{get(b:, "infos", "")} %= %Y  Col %c, Ln %l/%L  '
return M
