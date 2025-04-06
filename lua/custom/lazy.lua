local navigation = {
  'preservim/nerdtree',
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
  {
    'jasonpanosso/harpoon-tabline.nvim',
    dependencies = { 'ThePrimeagen/harpoon' },
  },
  { -- which-key
    -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
      require('which-key').setup()

      -- Document existing key chains
      require('which-key').add {
        { '<leader>c', group = '[C]ode' },
        { '<leader>c_', hidden = true },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>d_', hidden = true },
        { '<leader>r', group = '[R]ename' },
        { '<leader>r_', hidden = true },
        { '<leader>s', group = '[S]earch' },
        { '<leader>s_', hidden = true },
        { '<leader>t', group = '[T]est' },
        { '<leader>t_', hidden = true },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>w_', hidden = true },
      }
      -- visual mode
      require('which-key').add({
        { '<leader>h', desc = 'Git [H]unk', mode = 'v' },
      }, { mode = 'v' })
    end,
  },
}

local visuals = {
  { --tokyonight theme
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      vim.cmd.colorscheme 'tokyonight-night'
      -- You can configure highlights by doing something like:
      vim.cmd.hi 'Comment gui=none'
    end,
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'catppuccin-macchiato'
      vim.cmd.hi 'Comment gui=none'
      -- transparent background
      vim.cmd [[
          highlight Normal guibg=NONE
          highlight NonText guibg=NONE
          highlight Normal ctermbg=NONE
          highlight NonText ctermbg=NONE
      ]]
    end,
  },
  { -- todo-comments
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },
}

local utils = {
  'tpope/vim-fugitive', -- git inside vim
  'jiangmiao/auto-pairs', -- brackets are cool
  require 'kickstart.plugins.debug',
}

local custom = {
  { import = 'custom.plugins' },
}

local plugins = {}
vim.list_extend(plugins, navigation)
vim.list_extend(plugins, visuals)
vim.list_extend(plugins, utils)
vim.list_extend(plugins, custom)

return plugins
