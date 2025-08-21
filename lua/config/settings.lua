-- SETTINGS

-- Allow cursor to be placed at empty space
-- vim.o.virtualedit = 'all'

-- Allows open another buffer on unwritten buffers
vim.o.hidden = true

-- dynamic title
--vim.o.title = true

-- somrthing to do with tab
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.tabstop = 2

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
--vim.o.updatetime = 250

-- show errors and such in line numbers
--vim.o.signcolumn = 'number' -- auto, yes
vim.o.signcolumn = 'auto:1'

--vim.o.statuscolumn = "%=%{v:lnum} %s"

-- cursor line
vim.o.cursorline = true

-- tabline
--vim.o.showtabline = 2

-- highlight code blocks in markdown
vim.g.markdown_fenced_languages = { 'java', 'c', 'javascript', 'lua', 'html', 'css' }

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noinsert,noselect'

-- COLORSCHEME
vim.o.termguicolors = true

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'dart',
    callback = function()
        vim.bo.shiftwidth = 2
        vim.bo.expandtab = true
        vim.bo.tabstop = 2
    end,
})

vim.lsp.set_log_level('off')

vim.o.mousemodel = 'extend'

vim.cmd [[set list listchars=tab:»·,trail:·]]


local function setIbusOn()
vim.cmd [[
augroup ibus
    autocmd!
	autocmd InsertEnter *.md silent exe "!switch-ibus.sh vi"
	autocmd InsertLeave *.md silent exe "!switch-ibus.sh en"
augroup END
]]
end
local function setIbusOff()
vim.cmd [[
autocmd! ibus
]]
end

vim.api.nvim_create_user_command('AutoIbusOn', setIbusOn, {})
vim.api.nvim_create_user_command('AutoIbusOff', setIbusOff, {})

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
---@diagnostic disable-next-line: duplicate-set-field
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = "single"
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end
