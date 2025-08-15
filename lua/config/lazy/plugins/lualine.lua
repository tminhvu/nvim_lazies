local M = {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    event = "VeryLazy",
    init = function()
        local init_group = vim.api.nvim_create_augroup('reset_group', {
            clear = false,
        })

        vim.api.nvim_create_autocmd({ 'LspAttach' }, {
            callback = function()
                local lsp = vim.lsp.get_clients()
                local names = ''

                if lsp ~= nil then
                    for l = 1, #lsp do
                        --names = names .. '  ' .. lsp[l].name
                        if l > 1 then
                            names = names .. ', '
                        end
                        names = names .. lsp[l].name
                    end
                end

                vim.b.lsp_server = ' ' .. names
            end,
            group = init_group
        })
    end,
    opts = {
        options = {
            icons_enabled = true,
            theme = 'material',
            --component_separators = { left = '', right = '' },
            component_separators = { left = '', right = '' },
            section_separators = { left = '', right = '' },
            disabled_filetypes = {
                statusline = {},
                winbar = {},
            },
            ignore_focus = {},
            always_divide_middle = true,
            globalstatus = true,
            refresh = {
                statusline = 1000,
                tabline = 1000,
                winbar = 1000,
            }
        },
        sections = {
            lualine_a = { 'mode' },
            lualine_b = { 'branch', 'diff', 'diagnostics' },
            lualine_c = { { 'filename', path = 1 }, },
            lualine_x = {
                --function()
                --    -- invoke `progress` here.
                --    return require('lsp-progress').progress()
                --end,
                --'filetype' },
                'b:lsp_server' },
            lualine_y = { 'location' },
            lualine_z = { { 'datetime', style = "%H:%M" } }
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { 'filename' },
            lualine_x = { 'location' },
            lualine_y = {},
            lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = { 'nvim-tree' }
    }

}
return M
