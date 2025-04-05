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

return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
  {
    'jasonpanosso/harpoon-tabline.nvim',
    dependencies = { 'ThePrimeagen/harpoon' },
  },
  'tpope/vim-fugitive', -- git inside vim
  'jiangmiao/auto-pairs', -- brackets are cool
  'preservim/nerdtree',

  --
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
        { '<leader>h', group = 'Git [H]unk' },
        { '<leader>h_', hidden = true },
        { '<leader>r', group = '[R]ename' },
        { '<leader>r_', hidden = true },
        { '<leader>s', group = '[S]earch' },
        { '<leader>s_', hidden = true },
        { '<leader>t', group = '[T]oggle' },
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

  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.indent_line',
  -- require 'kickstart.plugins.lint',
  -- require 'kickstart.plugins.autopairs',
  -- require 'kickstart.plugins.neo-tree',
  -- require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --    For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
  -- { import = 'custom.plugins.nvim-dap' },
  { import = 'custom.plugins' },
  -- { import = 'custom.plugins.gitsigns' },
  -- -- { import = 'custom.plugins.markdown-preview' },
  -- -- { import = 'custom.plugins.mini' },
  -- -- { import = 'custom.plugins.nvim-cmp' },
  -- -- { import = 'custom.plugins.nvim-dap' },
  -- -- { import = 'custom.plugins.nvim-jdtls' },
  -- { import = 'custom.plugins.nvim-lspconfig' },
  -- { import = 'custom.plugins.telescope' },
  -- -- { import = 'custom.plugins.treesitter' },
  -- { import = 'custom.plugins.vim-test' },
  -- { import = 'custom.plugins.tmux' },
  -- { import = 'custom.plugins.conform' },
  -- { import = 'custom.plugins.completion' },
  -- { import = 'custom.plugins.lspsaga' },
  -- -- { import = 'custom.plugins.debug' },
  -- -- { import = 'custom.plugins.neotest.bak' },

  -- [[
  --    gitsigns
  --    markdown-preview
  --    mini
  --    nvim-cmp
  --    nvim-dap
  --    nvim-jdtls
  --    nvim-lspconfig
  --    telescope
  --    treesittter
  --    neotest.bak
  -- ]]

  -- { import = 'custom.plugins.telescope' },
  -- require 'lazy',
}
