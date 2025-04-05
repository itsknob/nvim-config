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
    {
      'microsoft/vscode-js-debug',
      build = 'npm i --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out',
    },
    {
      'mxsdev/nvim-dap-vscode-js',
      config = function()
        local js_langs = {
          'typescript',
          'javascript',
          'javascriptreact',
          'typescriptreact',
        }

        local dap = require 'dap'
        require('dap-vscode-js').setup {
          node_path = '/Users/stephen.reilly/.nvm/versions/node/v18.20.7/bin/node',
          debugger_path = vim.fn.resolve(vim.fn.stdpath 'data' .. '/lazy/vscode-js-debug'),
          debugger_cmd = { 'js-debug-adapter' },
          adapters = {
            'pwa-node',
            'pwa-chrome',
            'node-terminal',
            'node',
          },
        }

        for _, language in ipairs(js_langs) do
          dap.configurations[language] = {
            {
              type = 'pwa-node',
              request = 'attach',
              name = 'Attach',
              processId = require('dap.utils').pick_process,
              cwd = '${workspaceFolder}',
            },
            {
              type = 'node-terminal',
              request = 'launch',
              name = 'npm run test',
              command = 'test',
              cwd = '${workspaceFolder}',
              autoAttachChildProcesses = true,
            },
            {
              type = 'node-terminal',
              request = 'launch',
              name = 'npm run test:debug',
              command = 'npm run test:debug',
              cwd = '${workspaceFolder}',
              autoAttachChildProcesses = true,
            },
          }
        end
      end,
    },
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',
    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    dap.adapters['pwa-node:12'] = {
      type = 'server',
      host = 'localhost',
      port = '${port}',
      executable = {
        args = { vim.fn.expand '~/.local/share/nvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js', '${port}' },
        command = vim.fn.expand '~/.nvm/versions/node/v12.22.8/bin/node',
      },
    }

    -- dap.adapters['pwa-node:14'] = {
    --   type = 'server',
    --   host = 'localhost',
    --   port = '${port}',
    --   executable = {
    --     args = { vim.fn.expand '~/.local/share/nvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js', '${port}' },
    --     command = vim.fn.expand '~/.nvm/versions/node/v14.20.0/bin/node',
    --   },
    -- }

    dap.adapters['pwa-node:18'] = {
      type = 'server',
      host = 'localhost',
      port = '${port}',
      executable = {
        args = { vim.fn.expand '~/.local/share/nvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js', '${port}' },
        command = vim.fn.expand '~/.nvm/versions/node/v18.20.4/bin/node',
        -- command = vim.fn.expand("~/.nvm/versions/node/v12.22.8/bin/node"),
      },
    }

    -- dap.adapters['pwa-node:20'] = {
    --   type = 'server',
    --   host = 'localhost',
    --   port = '${port}',
    --   executable = {
    --     args = { vim.fn.expand '~/.local/share/nvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js', '${port}' },
    --     -- command = vim.fn.expand("~/.nvm/versions/node/v12.22.8/bin/node"),
    --     command = vim.fn.expand '~/.nvm/versions/node/v20.16.0/bin/node',
    --   },
    -- }

    dap.adapters['node'] = {
      type = 'server',
      host = 'localhost',
      port = '${port}',
      executable = {
        args = { vim.fn.expand '~/.local/share/nvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js', '${port}' },
        command = vim.fn.expand '~/.nvm/versions/node/v18.20.4/bin/node',
      },
    }

    -- dap.adapters["pwa-node"] = {
    --     type = "server",
    --     host = "localhost",
    --     port = "${port}",
    --     executable = {
    --         args = { vim.fn.expand("~/.local/share/nvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js"), "${port}" },
    --         command = vim.fn.expand("~/.nvm/versions/node/v18.20.4/bin/node"),
    --         -- command = vim.fn.expand("~/.nvm/versions/node/v12.22.8/bin/node"),
    --     }
    -- }

    local configurations = {
      {
        type = 'pwa-node:12',
        request = 'attach',
        name = 'Attach:12',
        address = 'localhost',
        port = '9229',
        processId = require('dap.utils').pick_process,
      },
      -- {
      --   type = 'pwa-node:14',
      --   request = 'attach',
      --   name = 'Attach 14',
      --   address = 'localhost',
      --   port = '9229',
      --   processId = require('dap.utils').pick_process,
      -- },
      -- {
      --   type = 'pwa-node:20',
      --   request = 'attach',
      --   name = 'Attach 20',
      --   address = 'localhost',
      --   port = '9229',
      --   processId = require('dap.utils').pick_process,
      -- },
      {
        type = 'pwa-node:18',
        request = 'attach',
        name = 'Attach 18',
        address = 'localhost',
        port = '9229',
        processId = require('dap.utils').pick_process,
      },
      {
        -- type = 'pwa-node',
        -- request = 'launch',
        -- name = 'Launch',
        -- runtimeArgs = { '--inspect' },
        -- port = '9229',
        -- cwd = '${workspaceFolder}',
        -- stopOnEntry = true,
        -- smartStep = true,
        -- continueOnAttach = true,
      },
      {
        type = 'pwa-node:18',
        request = 'launch',
        name = 'Jest Debug:react-scripts',
        cwd = '${workspaceFolder}',
        stopOnEntry = true,
        smartStep = true,
        runtimeExecutable = '/Users/stephen.reilly/.nvm/versions/node/v12.22.8/bin/node',
        runtimeArgs = {
          '${workspaceFolder}/node_modules/react-scripts/bin/react-scripts.js',
          'test',
          '--runInBand',
          '--env=jsdom',
        },
        rootPath = '${workspaceFolder}',
        console = 'integratedTerminal',
        internalConsoleOptions = 'neverOpen',
      },
      {
        type = 'pwa-node:12',
        request = 'launch',
        name = 'npm t:12',
        cwd = '${workspaceFolder}',
        stopOnEntry = true,
        smartStep = true,
        autoAttachChildProcesses = true,
        runtimeExecutable = '/Users/stephen.reilly/.nvm/versions/node/v12.22.8/bin/node',
        runtimeArgs = {
          '${workspaceFolder}/node_modules/jest/bin/jest.js',
          '--runInBand',
          '--env=jsdom',
          '--inspect',
        },
        rootPath = '${workspaceFolder}',
        console = 'integratedTerminal',
        internalConsoleOptions = 'neverOpen',
      },
      {
        type = 'pwa-node:18',
        request = 'launch',
        name = 'npm t:18',
        cwd = '${workspaceFolder}',
        stopOnEntry = true,
        smartStep = true,
        runtimeExecutable = '/Users/stephen.reilly/.nvm/versions/node/v18.20.4/bin/node',
        runtimeArgs = {
          '${workspaceFolder}/node_modules/jest/bin/jest.js',
          '--runInBand',
          '--env=jsdom',
          '--inspect',
        },
        rootPath = '${workspaceFolder}',
        console = 'integratedTerminal',
        internalConsoleOptions = 'neverOpen',
      },
    }

    -- -- Load launch.json
    -- -- require('dap.ext.vscode').load_launchjs()
    -- if vim.fn.filereadable '.vscode/launch.json' then
    --   local dap_vscode = require 'dap.ext.vscode'
    --   dap_vscode.load_launchjs(nil, {
    --     ['pwa-node'] = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
    --     ['node'] = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
    --     ['pwa-chrome'] = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
    --     ['chrome'] = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
    --   })
    -- end

    -- Dap configurations = { configurations .. launchConfigs }
    dap.configurations.javascript = configurations
    dap.configurations.javascriptreact = configurations
    dap.configurations.typescript = configurations
    dap.configurations.typescriptreact = configurations

    -- Dap Start Session
    vim.keymap.set('n', '<F5>', function()
      require('dap').continue()
    end)

    vim.keymap.set('n', '<Leader>dl', function()
      require('dap').run_last()
    end)

    vim.keymap.set('n', '<F6>', function()
      require('dapui').toggle()
    end)

    -- Dap Step(s)
    vim.keymap.set('n', '<F10>', function()
      require('dap').step_over()
    end)
    vim.keymap.set('n', '<F11>', function()
      require('dap').step_into()
    end)
    vim.keymap.set('n', '<F12>', function()
      require('dap').step_out()
    end)

    -- Breakpoints and Logpoints
    vim.keymap.set('n', '<Leader>b', function()
      require('dap').toggle_breakpoint()
    end)
    vim.keymap.set('n', '<Leader>B', function()
      require('dap').set_breakpoint()
    end)
    vim.keymap.set('n', '<Leader>lp', function()
      require('dap').set_breakpoint(nil, nil, vim.fn.input 'Log point message: ')
    end)

    -- Dap Widgets
    -- Hover
    vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function()
      require('dap.ui.widgets').hover()
    end)

    -- Preview
    vim.keymap.set({ 'n', 'v' }, '<Leader>dp', function()
      require('dap.ui.widgets').preview()
    end)

    -- Frames
    vim.keymap.set('n', '<Leader>df', function()
      local widgets = require 'dap.ui.widgets'
      widgets.centered_float(widgets.frames)
    end, { desc = '[D]ap [F]rames' })

    -- Scopes
    vim.keymap.set('n', '<Leader>ds', function()
      local widgets = require 'dap.ui.widgets'
      widgets.centered_float(widgets.scopes)
    end, { desc = '[D]ap [S]copes' })

    -- REPL
    vim.keymap.set('n', '<Leader>dr', function()
      require('dap').repl.open()
    end, { desc = '[D]ap REPL' })

    -- Custom DAP UI Stuff
    -- Reset the UI
    vim.keymap.set('n', '<Leader>dR', function()
      require('dapui').toggle { reset = true }
    end, { desc = '[D]ap UI [R]eset' })

    -- -- these should only be for java
    -- -- TODO: find out where to put these for java only
    -- vim.keymap.set('n', '<Leader>tc', function()
    --   require('jdtls.dap').test_class()
    -- end)
    -- vim.keymap.set('n', '<Leader>tm', function()
    --   require('jdtls.dap').test_nearest_method()
    -- end)

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
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
    }

    -- Auto Open on Init, Auto Close on Exit
    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Install golang specific config
    require('dap-go').setup {
      delve = {
        -- On Windows delve must be run attached or it crashes.
        -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
        detached = vim.fn.has 'win32' == 0,
      },
    }
  end,
}
