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
        spacing = 4,
        prefix = ' ', --ඞ
        suffix = '',
        severity = {
            --max = vim.diagnostic.severity.ERROR,
            --min = vim.diagnostic.severity.WARN,
            --      vim.diagnostic.severity.INFO,
            --      vim.diagnostic.severity.HINT
        }
    },
    update_in_insert = true,
    severity_sort = true,
    underline = {
        -- severity = {
        --     max = vim.diagnostic.severity.ERROR,
        --     min = vim.diagnostic.severity.WARN
        -- }
    },
    sign = true,
})

-- diagnostic sign 
local signs = {
    Error = "E", --􀌛
    Warn = "W", -- 
    Hint = "H", --
    Info = "I",
}

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- diagnostic popup
-- vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {border='rounded', focus=false})]]
