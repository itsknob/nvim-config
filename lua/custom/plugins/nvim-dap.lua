
-- @diagnostic disable: missing-fields
-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',
    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'
    local widgets = require 'dap.ui.widgets'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'delve',
      },
    }

    -- -- Basic debugging keymaps, feel free to change to your liking!
    -- Toggle UI
    vim.keymap.set('n', '<F6>', function()
      require('dapui').toggle()
    end)

    -- Debug Stepping
    vim.keymap.set('n', '<F5>', function()
      require('dap').continue()
    end)
    vim.keymap.set('n', '<F10>', function()
      require('dap').step_over()
    end)
    vim.keymap.set('n', '<F11>', function()
      require('dap').step_into()
    end)
    vim.keymap.set('n', '<F12>', function()
      require('dap').step_out()
    end)

    -- Breakpoints
    vim.keymap.set('n', '<Leader>b', function()
      require('dap').toggle_breakpoint()
    end)
    vim.keymap.set('n', '<leader>B', function()
      require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Debug: Set Breakpoint' })
    vim.keymap.set('n', '<Leader>lp', function()
      require('dap').set_breakpoint(nil, nil, vim.fn.input 'Log point message: ')
    end)

    -- Show Specific Widgets
    vim.keymap.set('n', '<Leader>dr', function()
      require('dap').repl.open()
    end)
    vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function()
      require('dap.ui.widgets').hover()
    end)
    vim.keymap.set({ 'n', 'v' }, '<Leader>dp', function()
      require('dap.ui.widgets').preview()
    end)
    vim.keymap.set('n', '<Leader>df', function()
      widgets.centered_float(widgets.frames)
    end)
    vim.keymap.set('n', '<Leader>ds', function()
      widgets.centered_float(widgets.scopes)
    end)

    -- Run Tests
    vim.keymap.set('n', '<Leader>dl', function()
      require('dap').run_last()
    end)
    -- JAVA
    -- vim.keymap.set('n', '<leader>tm',
    --         require('jdtls').test_nearest_method,
    --         { desc = "[T]est [M]ethod" }
    --     )
    -- vim.keymap.set('n', '<leader>tc',
    --         require('jdtls').test_class,
    --         { desc = "[T]est [C]lass" }
    --     )
    -- vim.keymap.set('n', '<leader>ta',
    --         require('jdtls').pick_test,
    --         { desc = "[T]est [A]ll" }
    --     )

    -- TODO: Figure out NeoTest
    -- local neotest = require("neotest")
    -- vim.keymap.set('n', '<Leader>tc', neotest.run.run(), { desc = "[T]est [C]losest" });
    -- vim.keymap.set('n', '<Leader>tm', ":TestNearest<cr>", { desc = "[T]est [C]losest" });
    -- vim.keymap.set('n', '<leader>ta', ":TestSuite<cr>", { desc = "[T]est [A]ll" }):

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        enabled = true,
        element = "console",
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
      layouts = {
        {
          elements = {
            {
              id = 'scopes',
              size = 0.25,
            },
            {
              id = 'watches',
              size = 0.5,
            },
            {
              id = 'breakpoints',
              size = 0.25,
            },
            -- {
            --     id = "stacks",
            --     size = 0.25
            -- },
          },
          position = 'right',
          size = 35,
        },
        {
          elements = {
            {
              id = 'repl',
              size = 0.75,
            },
            {
              id = 'console',
              size = 0.25,
            },
          },
          position = 'bottom',
          size = 15,
        },
      },
    }

    -- UI Window Behavior
    -- open when debugging
    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    -- don't close when finished
    -- dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    -- dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- DAP Clients
    -- Install golang specific config
    require('dap-go').setup {
      delve = {
        -- On Windows delve must be run attached or it crashes.
        -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
        detached = vim.fn.has 'win32' == 0,
      },
    }

    -- load launch.json
    require('dap.ext.vscode').load_launchjs()
  end,
}
