local m = require 'harpoon.mark'
local ui = require 'harpoon.ui'

function addAndRedraw()
  m.add_file()
  vim.cmd 'redrawt'
end

vim.keymap.set('n', '<leader>a', m.add_file, { desc = '[A]dd file to harpoon' })
vim.keymap.set('n', '<leader>h', ui.toggle_quick_menu, { desc = '[A]dd file to harpoon' })
vim.keymap.set('n', '<M-j>', ui.nav_prev, { desc = '[P]revious harpoon file' })
vim.keymap.set('n', '<M-k>', ui.nav_next, { desc = '[N]ext harpoon file' })

local tmux = require 'harpoon.tmux'
vim.keymap.set('n', '<leader>x', function()
  tmux.gotoTerminal(1)
end, { desc = 'Go to Termainl' })

require('harpoon').setup {
  menu = {
    width = math.floor(vim.api.nvim_win_get_width(0) * 0.6),
  },
  tabline = true,
  tabline_prefix = ' ',
  tabline_suffix = ' ',
}

-- Fancy Tabline Formatting showing Active Harpoon
vim.cmd 'highlight! HarpoonInactive guibg=NONE guifg=#63698c'
vim.cmd 'highlight! HarpoonActive guibg=NONE guifg=white'
vim.cmd 'highlight! HarpoonNumberActive guibg=NONE guifg=#7aa2f7'
vim.cmd 'highlight! HarpoonNumberInactive guibg=NONE guifg=#7aa2f7'
vim.cmd 'highlight! TabLineFill guibg=NONE guifg=white'
