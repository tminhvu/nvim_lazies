---- diagnostic sign
--local signs = {
--  Error = "",
--  Warn = "", -- 
--  Hint = "", --
--  Info = "",
--}

-- diagnostics config
vim.diagnostic.config({
    virtual_text = {
        spacing = 3,
        --prefix = '', --ඞ
        suffix = '',
        severity = {
            max = vim.diagnostic.severity.ERROR,
            min = vim.diagnostic.severity.WARN,
            --      vim.diagnostic.severity.INFO,
            --      vim.diagnostic.severity.HINT
        }
    },
    update_in_insert = true,
    severity_sort = true,
    underline = {
        severity = {
            max = vim.diagnostic.severity.ERROR,
            min = vim.diagnostic.severity.WARN
        }
    },
    sign = true,
})

--local signs = {
--      --Error = " ",
--      --Warn  = " ",
--      --Hint  = " ",
--      --Info  = " ",
--      Error = "E ",   
--      Warn  = "W ",
--      Hint  = "H ",
--      Info  = "I ",
--}
--for type, icon in pairs(signs) do
--    local hl = "DiagnosticSign" .. type
--    vim.fn.sign_define(hl, { text = icon, texthl = hl})
--end

-- Diagnostic keymaps
vim.api.nvim_set_keymap('n', '<leader>e',
    '<cmd>lua vim.diagnostic.open_float(nil, {focus=false})<CR>', {})
--'<cmd>lua vim.diagnostic.open_float(nil, {focus=false, border = "single"})<CR>', {})
vim.api.nvim_set_keymap('n', '<A-[>', '<cmd>lua vim.diagnostic.goto_prev()<CR>', {})
vim.api.nvim_set_keymap('n', '<A-]>', '<cmd>lua vim.diagnostic.goto_next()<CR>', {})
--vim.api.nvim_set_keymap('n', '<leader>a', '<cmd>lua vim.diagnostic.setloclist()<CR>', {})
