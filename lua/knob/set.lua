-- Leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Tabs vs Spaces
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Lines
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.o.breakindent = true

-- backups
vim.opt.swapfile = false
vim.opt.backup = false

-- mouse
vim.o.mouse = 'a'

-- mode
vim.o.showmode = false

-- huge undo list
vim.opt.undodir = os.getenv 'HOME' .. '/.vim/undodir'
vim.opt.undofile = true

-- search niceties
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.o.inccommand = 'split'

-- nice colors
vim.opt.termguicolors = true

-- don't scoll to the edge
vim.opt.scrolloff = 8

-- always show column for symbols
vim.opt.signcolumn = 'yes'

-- faster updates
vim.opt.updatetime = 50 -- fast update time

-- max line length column
vim.opt.colorcolumn = '80'
