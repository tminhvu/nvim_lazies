local M = {
    setup = function ()
        --vim.diagnostic.config({ virtual_text = {
        --  spacing = 5,
        --  prefix = ''
        --}, update_in_insert = true, underline = true, sign = true })
        ----vim.diagnostic.config({ virtual_text = false, update_in_insert = false, underline = true, sign = true })
        --
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
              max = vim.diagnostic.severity.ERROR,
              min = vim.diagnostic.severity.WARN,
              --      vim.diagnostic.severity.INFO,
              --      vim.diagnostic.severity.HINT
            }
          },
          update_in_insert = false,
          severity_sort = true,
          underline = {
            severity = {
              max = vim.diagnostic.severity.ERROR,
              min = vim.diagnostic.severity.WARN
            }
          },
          sign = true
        })
        --vim.diagnostic.config({ virtual_text = false, update_in_insert = false, underline = true, sign = true })

        -- diagnostic sign 
        local signs = {
          Error = "E", --􀌛
          Warn = "W", -- 
          Hint = "H", --
          Info = "I",
        }

        for type, icon in pairs(signs) do
          local hl = "DiagnosticSign" .. type
          vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
        end

        -- split border
        --vim.opt.fillchars:append({
        --  horiz = '━',
        --  horizup = '┻',
        --  horizdown = '┳',
        --  vert = '┃',
        --  vertleft = '┨',
        --  vertright = '┣',
        --  verthoriz = '╋',
        --})

        -- popup border
        --vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
        --  vim.lsp.handlers.hover, {
        --  border = "rounded"
        --})
        --
        --vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
        --  vim.lsp.handlers.signatureHelp, {
        --  border = "rounded"
        --})

        --vim.diagnostic.config({ float = { border = "rounded" } })

        -- diagnostic popup
        -- vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {border='rounded', focus=false})]]
    end
}

return M
