vim.cmd [[
cabbrev <expr> w getcmdtype()==':' && getcmdline() == "'<,'>w" ? '<c-u>w' : 'w'
]]

-- Scroll down 5 lines
vim.keymap.set('n', '<C-d>', '5j', { noremap = true, silent = true })
-- Scroll up 5 lines
vim.keymap.set('n', '<C-u>', '5k', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', 'q:', ':q', {})
vim.api.nvim_set_keymap('n', 'w:', ':w', {})
--vim.api.nvim_set_keymap('n', ';w', ':w', {})
--vim.api.nvim_set_keymap('n', ':q1', ':q!', {})
--vim.api.nvim_set_keymap('n', ';', ':', {})

-- jump between buffer
vim.api.nvim_set_keymap('n', '<C-b>', '<C-^>', {})
vim.api.nvim_set_keymap('n', '<Backspace>', ':bprevious<CR>', {})

vim.api.nvim_set_keymap('n', '<v-J>', 'Vj', {})
--Remap space as leader key
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--Add keymaps for telescopes
--vim.api.nvim_set_keymap('n', '<leader><leader>', ':Telescope resume<CR><ESC>', {})
--vim.api.nvim_set_keymap('n', '<leader>tt', ':Telescope builtin<CR>', {})
--vim.api.nvim_set_keymap('n', '<leader>tb', ':Telescope buffers<CR>', {})
--vim.api.nvim_set_keymap('n', '<leader>tf', ':Telescope find_files<CR>', {})
--vim.api.nvim_set_keymap('n', '<leader>tl', ':Telescope current_buffer_fuzzy_find<CR>', {})
--vim.api.nvim_set_keymap('n', '<leader>tg', ':Telescope live_grep<CR>', {})
--vim.api.nvim_set_keymap('n', '<leader>tof', ':Telescope oldfiles<CR>', {})
--vim.api.nvim_set_keymap('n', '<leader>tss', ':Telescope treesitter<CR>', {})
--vim.api.nvim_set_keymap('n', '<leader>tds', ':Telescope lsp_document_symbols<CR>', {})
--vim.api.nvim_set_keymap('n', '<leader>tr', ':Telescope lsp_references<CR>', {})
--vim.api.nvim_set_keymap('n', '<leader>ta', ':Telescope diagnostics<CR>', {})
--vim.api.nvim_set_keymap('n', '<leader>tdd', ':Telescope lsp_definitions<CR>', {})

vim.api.nvim_set_keymap('n', '<leader><leader>', ':FzfLua resume<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>tt', ':FzfLua builtin<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>tb', ':FzfLua buffers<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>tf', ':FzfLua files<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>tl', ':FzfLua blines<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>tg', ':FzfLua live_grep<CR>', {})
--vim.api.nvim_set_keymap('n', '<leader>tof', ':Telescope oldfiles<CR>', {})
--vim.api.nvim_set_keymap('n', '<leader>tss', ':Telescope treesitter<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>ts', ':FzfLua lsp_document_symbols<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>tr', ':FzfLua lsp_references<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>a', ':FzfLua lsp_workspace_diagnostics<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>ca', ':FzfLua lsp_code_actions<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>td', ':FzfLua lsp_definitions<CR>', {})

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
vim.api.nvim_set_keymap('n', '<F10>', ':silent! !xfce4-terminal --tab<cr><cr>', {})

-- to open file in browser
vim.api.nvim_create_user_command('BrowserOpen', 'silent! !brave-browser %:p<CR>', {})

--move in insertmode
vim.api.nvim_set_keymap('i', '<m-h>', '<Left>', {})
vim.api.nvim_set_keymap('i', '<m-l>', '<Right>', {})
vim.api.nvim_set_keymap('i', '<m-j>', '<Down>', {})
vim.api.nvim_set_keymap('i', '<m-k>', '<Up>', {})

--move in tab
vim.api.nvim_set_keymap('n', '<C-Left>', ':bprevious<CR>', {})
vim.api.nvim_set_keymap('n', '<C-Right>', ':bnext<CR>', {})
--vim.api.nvim_set_keymap('n', '<C-h>', ':bprevious<CR>', {})
--vim.api.nvim_set_keymap('n', '<C-l>', ':bnext<CR>', {})

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
--vim.api.nvim_create_user_command('q1', 'q!', {})

-- OTHER
vim.cmd [[
    " to compile and run c code
    autocmd FileType c nnoremap <buffer> <F9> :call RunC() <cr>
    " function to compile and run C code
    function! RunC()
        split | term c.sh %
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
        split | term l %
        startinsert
    endfunction

    autocmd FileType dart nnoremap <buffer> <F9> :call RunDart()<cr>
    function! RunDart()
        split | term dart run %
        startinsert
    endfunction
]]

-- Diagnostic keymaps
vim.api.nvim_set_keymap('n', '<leader>e',
    '<cmd>lua vim.diagnostic.open_float(nil, {focus=false})<CR>', {})
--'<cmd>lua vim.diagnostic.open_float(nil, {focus=false, border = "single"})<CR>', {})
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', {})
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', {})
--vim.api.nvim_set_keymap('n', '<leader>a', '<cmd>lua vim.diagnostic.setloclist()<CR>', {})

-- To really delete smth
vim.api.nvim_set_keymap('n', '\'', '"0', {})

-- I always like to prefix my commands with JR so I can easily find them
vim.api.nvim_create_user_command("Free", function()
    -- snag the file type from the buffer
    local file_type = vim.bo.filetype

    -- get the text from the visual selection as a table
    local text = vim.fn.getline(vim.fn.getpos("'<")[2], vim.fn.getpos("'>")[2])

    -- join it together into one string
    local full_text = table.concat(text, "\n")

    -- write the file to /tmp/freeze...probably could find a better place to put this so it's
    -- cross platform, but it works for me ¯\_(ツ)_/¯
    local file = io.open("/tmp/freeze", "w")
    if file == nil then
        print("could not open file")
        return
    end
    file:write(full_text)
    file:close()

    -- call the freeze command with the file type we grabbed earlier
    vim.fn.system("freeze -c ~/.config/nvim/freeze-conf.json /tmp/freeze -l" .. file_type .. " -o /tmp/freeze.jpg && xclip -sel clip -t image/jpg -i /tmp/freeze.jpg && cp /tmp/freeze.jpg ~/freeze-$(date +%Y_%m_%d_%T).jpg && notify-send 'Generated & Saved & Copied' '~/freeze-date.jpg'")
end, {
    -- make sure the command is only available in visual mode
    range = true,
})
