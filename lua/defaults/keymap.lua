vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Quickfix List Navigation
vim.keymap.set('n', '<M-n>', ':cnext', { desc = '[N]ext item in quickfix list' })
vim.keymap.set('n', '<M-p>', ':cprev', { desc = '[P]revious item in quickfix list' })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_next, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', '<M-n>', ':cn<cr>', { desc = '[N]ext item in quicklist' })
vim.keymap.set('n', '<M-p>', ':cp<cr>', { desc = '[P]revious item in quicklist' })

-- Centered Cursor Movement
vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]], { desc = 'Delete to void register' }) -- waits for motion
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]], { desc = '[Y]ank to system clipboard' }) -- waits for motion
vim.keymap.set('n', 'J', 'mzJ`z', { desc = "Don't go to end of first line when Joining" })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = "Don't go to end of first line when Joining" })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = "Don't go to end of first line when Joining" })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Center Screen when Searching' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Center Screen when Searching Reverse' })
vim.keymap.set('n', 'zF', '$zf%', { desc = "Fold from end of line to matching bracket" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('n', '<C-`>', ':buf term<CR>', { desc = 'Switch to buffer that starts with "term"' })

-- Keybinds to make split navigation easier.
-- Use CTRL+<hjkl> to switch between windows

-- Visual --
-- Bubble Line Up and Down
vim.keymap.set('v', '<C-J>', ':m .+1<CR>==', { desc = 'Bubble Line Up' })
vim.keymap.set('v', '<C-K>', ':m .-2<CR>==', { desc = 'Bubble Line Down' })

-- Visual Block --
-- Move text up and down
vim.keymap.set('x', 'J', ":move '>+1<CR>gv-gv", { desc = 'Bubble Line Up' })
vim.keymap.set('x', 'K', ":move '<-2<CR>gv-gv", { desc = 'Bubble Line Down' })
vim.keymap.set('x', '<C-J>', ":move '>+1<CR>gv-gv", { desc = 'Bubble Line Up' })
vim.keymap.set('x', '<C-K>', ":move '<-2<CR>gv-gv", { desc = 'Bubble Line down' })

-- Copy and Paste
-- Don't lose previous selection when pasting
vim.keymap.set('v', 'p', '"_dP', { desc = 'Paste keeping yank' })
-- System Clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>p', '"+p', { desc = 'Paste from System Clipboard' })
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y', { desc = 'Copy to System Clipboard' })

--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
-- open file under cursor in previous window
vim.keymap.set('n', '<leader>gf', '<C-W>gF', { desc = 'Open file under cursor in prev window' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Allow DAP Float Menus to be closed by pressing 'q'
vim.api.nvim_create_autocmd('FileType', {
  desc = 'Allows you close the DAP Float menus with q',
  group = vim.api.nvim_create_augroup('dap-float', { clear = true }),
  callback = function()
    -- vim.keymap.set('n', 'q', '<cmd>close!<CR>', { buffer = true, silent = true, noremap = true })
  end,
})

-- vim.keymap.set('n', '<leader>mp', ':MarkdownPreviewToggle<cr>', { desc = 'Toggle [M]arkdown [P]review' })

-- vim.api.nvim_create_autocmd('FileType', {
--     desc = "Starts up JDTLS Server when opening Java File",
--     group = vim.api.nvim_create_augroup('jdtls_lsp', { clear = true }),
--     callback = function()
--         if vim.bo.filetype == "java" then
--             print("Filetype: 'java'")
--             print("Starting JDTLS Server")
--             require('custom.jdtls_setup').setup()
--         end
--     end,
-- })
