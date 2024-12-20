return {
  'vim-test/vim-test',
  dependencies = {
    'preservim/vimux',
  },
  config = function()
    vim.keymap.set('n', '<leader>tt', ':TestNearest<CR>', { desc = 'Test Nearest' })
    vim.keymap.set('n', '<leader>tT', ':TestFile<CR>', { desc = 'Test File' })
    vim.keymap.set('n', '<leader>ta', ':TestSuite<CR>', { desc = 'Test Suite' })
    vim.keymap.set('n', '<leader>tl', ':TestLast<CR>', { desc = 'Test Last' })
    vim.keymap.set('n', '<leader>tg', ':TestVisit<CR>', { desc = 'Test Visited' })
    -- vim.cmd "let test#strategy = 'vimux'"
    vim.cmd "let test#strategy = 'neovim_sticky'"
  end,
}
