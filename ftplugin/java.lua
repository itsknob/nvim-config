-- Print contents of `tbl`, with indentation.
-- `indent` sets the initial level of indentation.
function tprint(tbl, indent)
  if not indent then
    indent = 0
  end
  for k, v in pairs(tbl) do
    formatting = string.rep('  ', indent) .. k .. ': '
    if type(v) == 'table' then
      print(formatting)
      tprint(v, indent + 1)
    elseif type(v) == 'boolean' then
      print(formatting .. tostring(v))
    else
      print(formatting .. v)
    end
  end
end
-- Anything in this directory is a filetype
-- Like an autocommand, it sees java it just runs

local status, jdtls = pcall(require, 'jdtls')
if not status then
  return
end

local mason_registry = require 'mason-registry'
local jdtls_install = mason_registry.get_package('jdtls'):get_install_path()
local path = {}
path.data_dir = vim.fn.stdpath 'cache' .. '/nvim-jdtls'
path.java_agent = jdtls_install .. '/lombok.jar'
path.launcher_jar = vim.fn.glob(jdtls_install .. '/plugins/org.eclipse.equinox.launcher_*.jar')

-- Platform specific path
if vim.fn.has 'mac' then
  path.platform_config = jdtls_install .. '/config_mac' -- Mac Specific
elseif vim.fn.has 'win32' then
  path.platform_config = jdtls_install .. '/config_win'
else
  path.platform_config = jdtls_install .. '/config_linux'
end

path.jdk_homes = '/Library/Java/JavaVirtualMachines/temurin-17.jdk/Contents/Home'

path.bundles = {}
--
-- java-test
local java_test_path = mason_registry.get_package('java-test'):get_install_path()
-- print(java_test_path)
local java_test_bundle = vim.split(vim.fn.glob(java_test_path .. '/extension/server/*.jar'), '\n')
-- print 'java_test_bundle'
-- tprint(java_test_bundle)
if java_test_bundle ~= nil and java_test_bundle[1] ~= '' then
  vim.list_extend(path.bundles, java_test_bundle)
end

-- java-debug-adapter
local java_debug_path = mason_registry.get_package('java-debug-adapter'):get_install_path()
-- print(java_debug_path)
local java_debug_bundle = vim.split(vim.fn.glob(java_debug_path .. '/extension/server/com.microsoft.java.debug.plugin-*.jar'), '\n')
-- print 'java_debug_bundle'
-- tprint(java_debug_bundle)
if java_debug_bundle[1] ~= '' then
  vim.list_extend(path.bundles, java_debug_bundle)
end

-- tprint(path.bundles)

-- java homes
path.jdk_21_home = '/Library/Java/JavaVirtualMachines/openjdk.jdk/Contents/Home'
path.jdk_17_home = '/Library/Java/JavaVirtualMachines/temurin-17.jdk/Contents/Home'
path.jdk_11_home = '/Library/Java/JavaVirtualMachines/temurin-11.jdk/Contents/Home'
path.jdk_8_home = '/Library/Java/JavaVirtualMachines/temurin-8.jdk/Contents/Home'

-- java runtimes
path.runtimes = {
  {
    name = 'JavaSE-1.8',
    path = path.jdk_8_home,
  },
  {
    name = 'JavaSE-11',
    path = path.jdk_11_home,
  },
  {
    name = 'JavaSE-17',
    path = path.jdk_17_home,
  },
}

-- find main classes
require('jdtls.dap').setup_dap_main_class_configs()

local data_dir = path.data_dir .. '/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

-- Project Roots
local root_markers = { '.git', 'mmvnw', 'gradlew', 'pom.xml', 'build.gradle' }
local root_dir = require('jdtls.setup').find_root(root_markers)
if root_dir == '' then
  return
end

local config = {
  cmd = {
    path.jdk_17_home .. '/bin/java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-javaagent:' .. path.java_agent,
    '-Xms4g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens',
    'java.base/java.util=ALL-UNNAMED',
    '--add-opens',
    'java.base/java.lang=ALL-UNNAMED',

    '-jar',
    path.launcher_jar,
    '-configuration',
    path.platform_config,
    '-data',
    data_dir,
  },
  root_dir = root_dir,
  settings = {
    java = {
      eclipse = {
        downloadSources = true,
      },
      configuration = {
        updateBuildConfiguration = 'interactive',
        runtimes = path.runtimes,
      },
      maven = {
        downloadSources = true,
      },
      implementationCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      format = {
        enabled = true,
        settings = {
          profile = 'GoogleStyle',
          url = 'https://raw.githubusercontent.com/snjeza/vscode-test/master/fluent.xml',
        },
      },
    },
    signatureHelp = {
      enabled = true,
    },
    completion = {
      favoriteStaticMembers = {
        'org.mockito.Mockito.*',
      },
    },
    extendedClientCapabilities = jdtls.extendedClientCapabilities,
    codeGeneration = {
      toString = {
        template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
      },
      useBlocks = true,
    },
  },
  on_attach = function(client, bufnr)
    jdtls.setup_dap { hotcodereplace = 'auto', config_overrides = {} }

    -- -- Keymaps for Java Debugging
    -- vim.keymap('n', '<Leader>tm', require('jdtls.dap').test_nearest_method())
    -- vim.keymap('n', '<Leader>tc', require('jdtls.dap').test_class())
    -- print 'Set jdtls keymaps'
  end,
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
  init_options = {
    bundles = path.bundles,
  },
}
jdtls.start_or_attach(config)
