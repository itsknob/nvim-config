vim.bo.makeprg = 'go run %<.go'
vim.keymap.set('n', '<Leader>m', ':make<cr>', { desc = '[M]ake and Run Go File' })

vim.cmd [[
" -- Auto Insert Matching Brace
inoremap {<CR> {<CR>}<Esc>ko
inoremap [<CR> [<CR>]<Esc>ko
inoremap (<CR> (<CR>)<Esc>ko

inoremap { {}<Esc>ha
inoremap ( ()<Esc>ha
inoremap [ []<Esc>ha
inoremap " ""<Esc>ha
inoremap ' ''<Esc>ha
inoremap ` ``<Esc>ha

]]
