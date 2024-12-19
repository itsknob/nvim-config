return {
  'alexghergh/nvim-tmux-navigation',
  config = function()
    require('nvim-tmux-navigation').setup {}
    vim.keymap.set('n', '<C-h>', '<Cmd>NvimTmuxNavigateLeft<CR>', {})
    vim.keymap.set('n', '<C-j>', '<Cmd>NvimTmuxNavigateDown<CR>', {})
    vim.keymap.set('n', '<C-k>', '<Cmd>NvimTmuxNavigateUp<CR>', {})
    vim.keymap.set('n', '<C-l>', '<Cmd>NvimTmuxNavigateRight<CR>', {})
    vim.cmd 'let g:VimuxHeight = 20'
    vim.cmd 'let g:tmux_navigator_save_on_switch = 2'
  end,
}
