--[[
DEPRECATED
]]

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
    -- Inline text with dap results
    'theHamsta/nvim-dap-virtual-text',
    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'mxsdev/nvim-dap-vscode-js',
    'leoluz/nvim-dap-go',
  },
  config = function()
    local dap = require 'dap'

    require('dap-vscode-js').setup {
      node_path = 'node',
      debugger_path = os.getenv 'HOME' .. '/.DAP/vscode-js-debug',
      adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
    }

    local exts = {
      'javascript',
      'typescript',
      'javascriptreact',
      'typescriptreact',
      -- using pwa-chrome
      'vue',
      'svelte',
    }

    for _, ext in ipairs(exts) do
      dap.configurations[ext] = {
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch Current File (pwa-node)',
          cwd = vim.fn.getcwd(),
          args = { '${file}' },
          sourceMaps = true,
          protocol = 'inspector',
        },
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch Current File (pwa-node with ts-node)',
          cwd = vim.fn.getcwd(),
          runtimeArgs = { '--loader', 'ts-node/esm' },
          runtimeExecutable = 'node',
          args = { '${file}' },
          sourceMaps = true,
          protocol = 'inspector',
          skipFiles = { '<node_internals>/**', 'node_modules/**' },
          resolveSourceMapLocations = {
            '${workspaceFolder}/**',
            '!**/node_modules/**',
          },
        },
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch Current File (pwa-node with deno)',
          cwd = vim.fn.getcwd(),
          runtimeArgs = { 'run', '--inspect-brk', '--allow-all', '${file}' },
          runtimeExecutable = 'deno',
          attachSimplePort = 9229,
        },
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch Test Current File (pwa-node with jest)',
          cwd = vim.fn.getcwd(),
          runtimeArgs = { '${workspaceFolder}/node_modules/.bin/jest' },
          runtimeExecutable = 'node',
          args = { '${file}', '--coverage', 'false' },
          rootPath = '${workspaceFolder}',
          sourceMaps = true,
          console = 'integratedTerminal',
          internalConsoleOptions = 'neverOpen',
          skipFiles = { '<node_internals>/**', 'node_modules/**' },
        },
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch Test Current File (pwa-node with vitest)',
          cwd = vim.fn.getcwd(),
          program = '${workspaceFolder}/node_modules/vitest/vitest.mjs',
          args = { '--inspect-brk', '--threads', 'false', 'run', '${file}' },
          autoAttachChildProcesses = true,
          smartStep = true,
          console = 'integratedTerminal',
          skipFiles = { '<node_internals>/**', 'node_modules/**' },
        },
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch Test Current File (pwa-node with deno)',
          cwd = vim.fn.getcwd(),
          runtimeArgs = { 'test', '--inspect-brk', '--allow-all', '${file}' },
          runtimeExecutable = 'deno',
          attachSimplePort = 9229,
        },
        {
          type = 'pwa-chrome',
          request = 'attach',
          name = 'Attach Program (pwa-chrome = { port: 9222 })',
          program = '${file}',
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          port = 9222,
          webRoot = '${workspaceFolder}',
        },
        {
          type = 'node2',
          request = 'attach',
          name = 'Attach Program (Node2)',
          processId = require('dap.utils').pick_process,
        },
        {
          type = 'node2',
          request = 'attach',
          name = 'Attach Program (Node2 with ts-node)',
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          skipFiles = { '<node_internals>/**' },
          port = 9229,
        },
        {
          type = 'pwa-node',
          request = 'attach',
          name = 'Attach Program (pwa-node)',
          cwd = vim.fn.getcwd(),
          processId = require('dap.utils').pick_process,
          skipFiles = { '<node_internals>/**' },
        },
      }
    end

    --[[ local vscodeJsDap = require 'dap-vscode-js'

    vscodeJsDap.setup {
      debugger_path = '~/.config/nvim/packages/vscode-js-debug/out/',
      adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
    }

    for _, language in ipairs { 'typescript', 'javascript' } do
      dap.configurations[language] = {
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch File',
          program = '${workspaceFolder}',
          cwd = '${workspaceFolder}',
        },
        {
          type = 'pwa-node',
          request = 'attach',
          name = 'Attach',
          processId = require('dap.utils').pick_process,
          cwd = '${workspaceFolder}',
        },
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Debug Jest Tests',
          -- trace = true, -- include debugger info
          runtimeExecutable = 'node',
          runtimeArgs = {
            './node_modules/jest/bin/jest.js',
            '--runInBand',
          },
          rootPath = '${workspaceFolder}',
          cwd = '${workspaceFolder}',
          console = 'integratedTerminal',
          internalConsoleOptions = 'neverOpen',
        },
      }
    end ]]

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
        'jdtls',
      },
    }

    -- -- Basic debugging keymaps, feel free to change to your liking!
    -- Toggle UI
    vim.keymap.set('n', '<F6>', function()
      require('dapui').toggle()
    end, { desc = 'Toggle DapUI' })

    -- Debug Stepping
    vim.keymap.set('n', '<F5>', function()
      require('dap').continue()
    end, { desc = 'Continue' })
    vim.keymap.set('n', '<F10>', function()
      require('dap').step_over()
    end, { desc = 'Step Over' })
    vim.keymap.set('n', '<F11>', function()
      require('dap').step_into()
    end, { desc = 'Step Into' })
    vim.keymap.set('n', '<F12>', function()
      require('dap').step_out()
    end, { desc = 'Step Out' })

    -- Breakpoints
    vim.keymap.set('n', '<Leader>b', function()
      require('dap').toggle_breakpoint()
    end, { desc = 'Toggle [b]reakpoint' })
    vim.keymap.set('n', '<leader>B', function()
      require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Conditional [B]reakpoint' })
    vim.keymap.set('n', '<Leader>lp', function()
      require('dap').set_breakpoint(nil, nil, vim.fn.input 'Log point message: ')
    end, { desc = 'Set [L]og [P]oint' })

    -- Show Specific Widgets
    vim.keymap.set('n', '<Leader>dr', function()
      require('dap').repl.open()
    end, { desc = 'Open [R]EPL' })
    vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function()
      require('dap.ui.widgets').hover()
    end, { desc = '[D]ebugger [H]over' })
    vim.keymap.set({ 'n', 'v' }, '<Leader>dp', function()
      require('dap.ui.widgets').preview()
    end, { desc = '[D]ebugger [P]review Widgets' })
    vim.keymap.set('n', '<Leader>df', function()
      widgets.centered_float(widgets.frames)
    end, { desc = '[D]ebugger [F]rames' })
    vim.keymap.set('n', '<Leader>ds', function()
      widgets.centered_float(widgets.scopes)
    end, { desc = '[D]ebugger [S]copes' })

    -- Run Tests
    vim.keymap.set('n', '<Leader>dl', function()
      require('dap').run_last()
    end, { desc = '[D]ebugger Run [L]ast' })

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
        element = 'console',
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
