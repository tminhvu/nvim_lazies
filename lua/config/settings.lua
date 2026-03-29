-- SETTINGS

-- Allow cursor to be placed at empty space
--vim.o.virtualedit = 'all'
vim.o.hidden = true
vim.o.title = true
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.conceallevel = 2
vim.o.wrap = true
vim.o.linebreak = true
vim.o.showmode = false
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.mousefocus = true
vim.o.spell = false

-- 85 char columns
--vim.o.colorcolumn = "85"
--vim.cmd [[
--" delete trailing whitespace
--autocmd BufWritePre * %s/\s\+$//e
--]]

-- Foldings
--vim.o.foldmethod = "indent"
--vim.o.foldtext = ""
--vim.o.foldlevel = 20
--vim.o.foldenable = false
--vim.o.foldminlines = 1


vim.o.foldmethod = "expr"
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.o.foldtext =
[[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]
vim.o.fillchars = "fold: "
vim.o.foldlevel = 20
vim.o.foldenable = false
vim.o.foldminlines = 1

vim.wo.number = true
vim.o.mouse = 'a'
vim.o.breakindent = true
vim.opt.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'auto:3'
vim.o.cursorline = true
--vim.o.showtabline = 2
vim.g.markdown_fenced_languages = { 'java', 'c', 'javascript', 'lua', 'html', 'css' }
vim.o.completeopt = 'menuone,noinsert,noselect'
vim.o.termguicolors = true

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'dart',
    callback = function()
        vim.bo.shiftwidth = 2
        vim.bo.expandtab = true
        vim.bo.tabstop = 2
    end,
})
vim.o.mousemodel = 'extend'
--vim.lsp.set_log_level('off')
--vim.cmd [[set list listchars=tab:»·,trail:·]]
--local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
-----@diagnostic disable-next-line: duplicate-set-field
--function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
--  opts = opts or {}
--  opts.border = "single"
--  return orig_util_open_floating_preview(contents, syntax, opts, ...)
--end
