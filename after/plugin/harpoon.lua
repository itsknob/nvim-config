local harpoon = require 'harpoon'
local harpoontabline = require 'harpoon-tabline'
-- local m = harpoon.mark
local ui = harpoon.ui

-- REQUIRED --
harpoon:setup()
harpoontabline.setup()
-- REQUIRED --

-- local function addAndRedraw()
--   m.add_file()
--   vim.cmd 'redrawt'
-- end

vim.keymap.set('n', '<leader>a', function() harpoon:list():add() end, { desc = '[A]dd file to harpoon' })
vim.keymap.set('n', '<leader>h', function() ui:toggle_quick_menu(harpoon:list()) end, { desc = '[A]dd file to harpoon' })
vim.keymap.set('n', '<M-j>', function() harpoon:list():prev() end, { desc = '[P]revious harpoon file' })
vim.keymap.set('n', '<M-k>', function() harpoon:list():next() end, { desc = '[N]ext harpoon file' })

-- Fancy Tabline Formatting showing Active Harpoon
vim.cmd 'highlight! HarpoonInactive guibg=NONE guifg=#63698c'
vim.cmd 'highlight! HarpoonActive guibg=NONE guifg=white'
vim.cmd 'highlight! HarpoonNumberActive guibg=NONE guifg=#7aa2f7'
vim.cmd 'highlight! HarpoonNumberInactive guibg=NONE guifg=#7aa2f7'
vim.cmd 'highlight! TabLineFill guibg=NONE guifg=white'

-- TODO - move to this 
vim.api.nvim_set_hl(0, 'HarpoonActive', { foreground = 'white', background = 'NONE' })
vim.api.nvim_set_hl(0, 'HarpoonInactive', { foreground = '#63698c', background = 'NONE' })
vim.api.nvim_set_hl(0, 'HarpoonNumberActive', { foreground = '#7aa2f7', background = 'NONE' })
vim.api.nvim_set_hl(0, 'HarpoonNumberInactive', { foreground = '#7aa2f7', background = 'NONE' })
vim.api.nvim_set_hl(0, 'TabLineFill', { foreground = 'white', background = 'NONE' })
