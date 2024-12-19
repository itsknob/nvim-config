return {
  'theprimeagen/harpoon', -- movement the right way
  'tpope/vim-fugitive', -- git inside vim
  'jiangmiao/auto-pairs', -- brackets are cool

  'preservim/nerdtree',

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} }, -- Comment keybindings

  { -- which-key
    -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
      require('which-key').setup()

      -- Document existing key chains
      require('which-key').register {
        ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
        ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
        ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
        ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
        ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
        ['<leader>t'] = { name = '[T]oggle', _ = 'which_key_ignore' },
        ['<leader>h'] = { name = 'Git [H]unk', _ = 'which_key_ignore' },
      }
      -- visual mode
      require('which-key').register({
        ['<leader>h'] = { 'Git [H]unk' },
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
  { import = 'custom.plugins.gitsigns' },
  -- { import = 'custom.plugins.markdown-preview' },
  -- { import = 'custom.plugins.mini' },
  { import = 'custom.plugins.nvim-cmp' },
  -- { import = 'custom.plugins.nvim-dap' },
  { import = 'custom.plugins.nvim-jdtls' },
  { import = 'custom.plugins.nvim-lspconfig' },
  { import = 'custom.plugins.telescope' },
  { import = 'custom.plugins.treesitter' },
  { import = 'custom.plugins.vim-test' },
  { import = 'custom.plugins.tmux' },
  { import = 'custom.plugins.conform' },
  -- { import = 'custom.plugins.neotest.bak' },

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
