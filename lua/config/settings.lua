-- SETTINGS

-- Allow cursor to be placed at empty space
-- vim.o.virtualedit = 'all'

-- Allows open another buffer on unwritten buffers
vim.o.hidden = true

-- dynamic title
vim.o.title = true

-- somrthing to do with tab
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.tabstop = 4

-- relative number
--vim.o.relativenumber = true

-- conceal lever for markdown and such
vim.o.conceallevel = 2

-- wrap words
vim.o.wrap = true
vim.o.linebreak = true

-- showing the mode under statusline
-- vim.o.showmode = true

-- split direction
vim.o.splitbelow = true
vim.o.splitright = true

-- mouse focus
vim.o.mousefocus = true

-- auto change direction
--vim.o.autochdir = true

-- spelling
vim.o.spell = false

-- 85 char columns
--vim.o.colorcolumn = "85"
vim.cmd [[
" delete trailing whitespace
autocmd BufWritePre * %s/\s\+$//e
]]

-- Foldings
vim.o.foldmethod = "indent"
vim.o.foldtext = ""
vim.o.foldlevel = 20
vim.o.foldenable = false

--vim.o.foldmethod = "expr"
--vim.o.foldexpr = "nvim_treesitter#foldexpr()"
----vim.o.foldtext = [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]
--vim.o.fillchars = "fold: "
--vim.o.foldlevel = 20
--vim.o.foldenable = false
vim.o.foldminlines = 1

--Set highlight on search
-- vim.o.hlsearch = true

--Make line numbers default
vim.wo.number = true

--Enable mouse mode
vim.o.mouse = 'a'

--Enable break indent
vim.o.breakindent = true

--Save undo history
vim.opt.undofile = true

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

--Decrease update time
vim.o.updatetime = 250

-- show errors and such in line numbers
--vim.o.signcolumn = 'number' -- auto, yes
vim.o.signcolumn = 'auto'

-- cursor line
vim.o.cursorline = true

-- tabline
--vim.o.showtabline = 2

-- highlight code blocks in markdown
vim.g.markdown_fenced_languages = { 'java', 'c', 'javascript', 'lua', 'html', 'css' }

---- diagnostics config
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

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noinsert,noselect'

-- COLORSCHEME
vim.o.termguicolors = true

vim.lsp.set_log_level('off')

-- vim: ts=2 sts=2 sw=2 et
