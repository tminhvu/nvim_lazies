-- jump between buffer
vim.api.nvim_set_keymap('n', '<C-b>', '<C-^>', {})

--Remap space as leader key
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--Add keymaps for telescopes
vim.api.nvim_set_keymap('n', '<leader>tt', ':Telescope builtin<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>tb', ':Telescope buffers<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>tf', ':Telescope find_files<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>tl', ':Telescope current_buffer_fuzzy_find<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>tg', ':Telescope live_grep<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>tof', ':Telescope oldfiles<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>tss', ':Telescope treesitter<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>tds', ':Telescope lsp_document_symbols<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>tr', ':Telescope lsp_references<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>ta', ':Telescope diagnostics<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>tdd', ':Telescope lsp_definitions<CR>', {})

-- to open nvim tree
vim.api.nvim_set_keymap("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = false, silent = true })

-- to generate doc using neogen
vim.api.nvim_set_keymap("n", "<Leader>do", ":Neogen<CR>", { noremap = true, silent = true })

-- to copy from and to
vim.api.nvim_set_keymap('v', '<C-c>', '"*y :let @+=@*<CR>', {})
vim.api.nvim_set_keymap('i', '<C-v>', '<Esc>"+p', {})

-- to open thunar
vim.api.nvim_set_keymap('n', '<F8>', ':silent! !thunar %:p:h<CR>', {})

--to open terminal
vim.api.nvim_set_keymap('n', '<F10>', ':!xfce4-terminal --tab<cr><cr>', {})

-- to open file in browser
vim.api.nvim_create_user_command('BrowserOpen', 'silent! !brave-browser %:p<CR>',{})

--move in insertmode
vim.api.nvim_set_keymap('i', '<m-h>', '<Left>', {})
vim.api.nvim_set_keymap('i', '<m-l>', '<Right>', {})
vim.api.nvim_set_keymap('i', '<m-j>', '<Down>', {})
vim.api.nvim_set_keymap('i', '<m-k>', '<Up>', {})

--move in tab
vim.api.nvim_set_keymap('n', '<C-Left>', ':tabprevious<CR>', {})
vim.api.nvim_set_keymap('n', '<C-Right>', ':tabnext<CR>', {})
vim.api.nvim_set_keymap('n', '<C-h>', ':tabprevious<CR>', {})
vim.api.nvim_set_keymap('n', '<C-l>', ':tabnext<CR>', {})

--move in plit
vim.api.nvim_set_keymap('n', '<M-Down>', ' <C-W><C-J>', {})
vim.api.nvim_set_keymap('n', '<M-Up>', '<C-W><C-K>', {})
vim.api.nvim_set_keymap('n', '<M-Right>', '<C-W><C-L>', {})
vim.api.nvim_set_keymap('n', '<M-Left>', '<C-W><C-H>', {})
vim.api.nvim_set_keymap('n', '<M-j>', '<C-W><C-J>', {})
vim.api.nvim_set_keymap('n', '<M-k>', '<C-W><C-K>', {})
vim.api.nvim_set_keymap('n', '<M-l>', '<C-W><C-L>', {})
vim.api.nvim_set_keymap('n', '<M-h>', '<C-W><C-H>', {})

-- jump up and down wraped lines
--Remap for dealing with word wrap
vim.api.nvim_set_keymap('n', '<C-k>', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-j>', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- map W to write
vim.api.nvim_create_user_command('W', 'write', {})
vim.api.nvim_create_user_command('Wq', 'wq', {})
vim.api.nvim_create_user_command('Wqa', 'wqa', {})
vim.api.nvim_create_user_command('Q', 'q', {})
vim.api.nvim_create_user_command('Qa', 'qa', {})

-- OTHER
vim.cmd [[
    " to compile and run python code
    autocmd FileType python nnoremap <buffer> <F9> :update<bar>!python %<CR>
    autocmd FileType python inoremap <buffer> <F9> <Esc>:update<bar>!python %<CR>

    " to compile and run c code
    autocmd FileType c nnoremap <buffer> <F9> :call RunC() <cr>
    " function to compile and run C code
    function! RunC()
        split | term c %
        startinsert
    endfunction

    " to compile and run java code
    autocmd FileType java nnoremap <buffer> <F9> :call RunJava() <cr>
    function! RunJava()
        split | term ja %
        startinsert
    endfunction

    " to compile and run javascript code
    autocmd FileType javascript nnoremap <buffer> <F9> :call RunJavaScript()<cr>
    function! RunJavaScript()
        split | term node %
        startinsert
    endfunction

    autocmd FileType lua nnoremap <buffer> <F9> :call RunLua()<cr>
    function! RunLua()
        split | term lua %
        startinsert
    endfunction
]]

-- Diagnostic keymaps
vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', {})
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', {})
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>a', '<cmd>lua vim.diagnostic.setloclist()<CR>', {})

-- To really delete smth
vim.api.nvim_set_keymap('n', '\'', '"0', {})
