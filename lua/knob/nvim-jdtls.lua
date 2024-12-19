---------
--- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/setup-with-nvim-jdtls.md
---------
local java_cmds = vim.api.nvim_create_augroup('java_cmds', { clear = true })
local cache_vars = {}

local jdk_21_home = '/Library/Java/JavaVirtualMachines/openjdk.jdk/Contents/Home'
local jdk_17_home = '/Library/Java/JavaVirtualMachines/temurin-17.jdk/Contents/Home'
local jdk_11_home = '/Library/Java/JavaVirtualMachines/temurin-11.jdk/Contents/Home'
local jdk_8_home = '/Library/Java/JavaVirtualMachines/temurin-8.jdk/Contents/Home'

local root_files = {
    '.git',
    'mvnw',
    'pom.xml'
}

local features = {
    codelens = false,
    debugger = true, -- we have nvim-dap
}

local function get_jdtls_paths()
    -- Get JDTLS Paths used for LSP Server
    if cache_vars.paths then
        return cache_vars.paths
    end

    local path = {}
    path.data_dir = vim.fn.stdpath('cache') .. '/nvim-jdtls'

    local jdtls_install = require('mason-registry')
        .get_package('jdtls')
        :get_install_path()

    path.java_agent = jdtls_install .. '/lombok.jar'
    path.launcher_jar = vim.fn.glob(jdtls_install .. '/plugins/org.eclipse.equinox.launcher_*.jar')

    if vim.fn.has('mac') == 1 then
        path.platform_config = jdtls_install .. '/config_mac'
    elseif vim.fn.has('unix') == 1 then
        path.platform_config = jdtls_install .. '/config_linux'
    elseif vim.fn.has('win32') == 1 then
        path.platform_config = jdtls_install .. '/config_win'
    end

    path.bundles = {}

    -- Include Java-Test Bundle ifits present
    local java_test_path = require('mason-registry')
        .get_package('java-test')
        :get_install_path()
    local java_test_bundle = vim.split(
        vim.fn.glob(java_test_path .. '/extension/server/*.jar'),
        '\n'
    )
    if java_test_bundle[1] ~= '' then
        vim.list_extend(path.bundles, java_test_bundle)
    end

    -- Include java-debug-adapter ifits present
    local java_debug_path = require('mason-registry')
        .get_package('java-debug-adapter')
        :get_install_path()
    local java_debug_bundle = vim.split(
        vim.fn.glob(java_debug_path .. '/extension/server/com.microsoft.java.debug.plugin-*.jar'),
        '\n'
    )
    if java_debug_bundle[1] ~= '' then
        vim.list_extend(path.bundles, java_debug_bundle)
    end

    path.runtimes = {
      {
        name = 'JavaSE-1.8',
        path = jdk_8_home
      },
      {
        name = 'JavaSE-11',
        path = jdk_11_home,
      },
      {
        name = 'JavaSE-17',
        path = jdk_17_home,
      },
      {
        name = 'JavaSE-21',
        path = jdk_21_home
      }
    }

    cache_vars.paths = path

    return path
end

local function enable_codelens(bufnr)
    pcall(vim.lsp.codelens.refresh)

    vim.api.nvim_create_autocmd('BufWritePost', {
        buffer = bufnr,
        group = java_cmds,
        desc = 'refresh codelens',
        callback = function()
            pcall(vim.lsp.codelens.refresh)
        end,
    })
end

local function enable_debugger(bufnr)
    require('jdtls').setup_dap({hotcodereplace = 'auto'})
    require('jdtls.dap').setup_dap_main_class_configs()

    local opts = {buffer = bufnr}
    vim.keymap.set('n', '<leader>tc', "<cmd>lua require('jdtls').test_class()<cr>", opts)
    vim.keymap.set('n', '<leader>tm', "<cmd>lua require('jdtls').test_nearest_method()()<cr>", opts)
end

local function jdtls_on_attach(client, bufnr)
    -- Executed when jdtls attaches to file
    -- Add Keybindings here
    if features.debugger then
        enable_debugger(bufnr)
    end
    if features.codelens then
        enable_codelens(bufnr)
    end

    -- this is where you could add those recommended keymaps from nvim-jdtls
    -- like extract_variable or extract_method
end

local function jdtls_setup(event)
    -- setup nvim-jdtls
    -- runs when opening java file

    local jdtls = require('jdtls')

    local path = get_jdtls_paths()
    local data_dir = path.data_dir .. '/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

    if cache_vars.cababilities == nil then
        jdtls.extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

        local ok_cmp, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
        cache_vars.capabilities = vim.tbl_deep_extend(
            'force',
            vim.lsp.protocol.make_client_capabilities(),
            ok_cmp and cmp_lsp.default_capabilities() or {}
        )
    end

    local cmd = {
        jdk_17_home,
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xmx1g",
        "-javaagent:" .. path.java_agent,
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",
        '-jar',
        path.launcher_jar,
        '-configuration',
        path.platform_config,
        '-data',
        data_dir,
    }

    local lsp_settings = {
        java  = {
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
            implementationsCodeLens = {
                enable = true,
            },
            referencesCodeLens = {
                enabled = true,
            },
            format = {
                enabled = true,
                -- settings = {
                --     profile = 'asdf'
                -- },
            }
        },
        signature_help = {
            enabled = true,
        },
        completion = {
            favoriteSataticMemebers = {
                'org.mockito.Mockito.*',
                -- 'add.Other.Things.You.Want.At.Top',
                -- 'of.Completion.Suggestions'
            },
        },
        contentProvider = {
            -- no idea what this is
            preferred = 'fernflower'
        },
        extendedClientCapabilities = jdtls.extendedClientCapabilities,
        codeGeneration = {
            toString = {
                template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
            },
            useBlocks = true,
        },
    }

    jdtls.start_or_attach({
        cmd = cmd,
        settings = lsp_settings,
        on_attach = jdtls_on_attach,
        capabilities = cache_vars.capabilities,
        root_dir = jdtls.setup.find_root(root_files),
        flags = {
            allow_incremental_sync = true,
        },
        init_options = {
            bundles = path.bundles,
        },
    })
end

vim.api.nvim_create_autocmd('FileType', {
    group = java_cmds,
    pattern = {'java'},
    desc = 'Setup jdtls',
    callback = jdtls_setup,
})
