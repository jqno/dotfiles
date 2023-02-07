local This = {}

local dap = require('dap')
local jdtls = require('jdtls')

function This.dap_run_test()
    dap.repl.open()
    jdtls.test_class()
end

function This.dap_run_test_nearest()
    dap.repl.open()
    jdtls.test_nearest_method()
end

local function on_attach(client, bufnr)
    require('util.lsp').on_attach(client, bufnr)

    require('jdtls.setup').add_commands()
    require('jdtls').setup_dap({ hotcodereplace = 'auto' })
    require('jdtls.dap').setup_dap_main_class_configs()
    require('config.mappings').setup_dap(bufnr)

    client.server_capabilities.documentFormattingProvider = false

    local map = vim.keymap.set
    local modes = require('util.modes')

    map(modes.n, '<leader>dr', require('dap').continue, { buffer = bufnr, desc = 'debug: run' })
    map(modes.n, '<leader>dt', require('filetypes.java').dap_run_test, { buffer = bufnr, desc = 'debug: test file' })
    map(modes.n, '<leader>dn', require('filetypes.java').dap_run_test_nearest,
        { buffer = bufnr, desc = 'debug: run nearest test' })

    map(modes.n, '<leader>gs', require('jdtls').super_implementation,
        { buffer = bufnr, desc = 'go to super implementation' })

    map(modes.n, '<leader>rR', function() require('jdtls').code_action(false, 'refactor') end,
        { buffer = bufnr, desc = 'refactor: menu' })
    map(modes.n, '<leader>rm', require('jdtls').extract_method, { buffer = bufnr, desc = 'refactor: extract method' })
    map(modes.v, '<leader>rm', function() require('jdtls').extract_method(true) end,
        { buffer = bufnr, desc = 'refactor: extract method' })
    map(modes.n, '<leader>ro', require('jdtls').organize_imports, { buffer = bufnr, desc = 'refactor: organize imports' })
    map(modes.n, '<leader>rv', require('jdtls').extract_variable, { buffer = bufnr, desc = 'refactor: extract variable' })
    map(modes.v, '<leader>rv', function() require('jdtls').extract_variable(true) end,
        { buffer = bufnr, desc = 'refactor: extract variable' })
    map(modes.n, '<leader>rV', require('jdtls').extract_variable_all,
        { buffer = bufnr, desc = 'refactor: extract variable (all occurrences)' })

    local floaterm = require('util.floaterm')
    map(modes.n, '<leader>m<space>', function() floaterm.floatermsend('jbang ' .. vim.fn.expand('%:p') .. '') end
        , { buffer = bufnr, desc = 'run with JBang' })
    map(modes.n, '<leader>mr', require('jdtls').update_project_config,
        { buffer = bufnr, desc = 'reload build configuration' })
    map(modes.n, '<leader>mcc', function() floaterm.floatermsend('mvnd clean test-compile') end,
        { buffer = bufnr, desc = 'mvn clean compile' })
    map(modes.n, '<leader>mcv', function() floaterm.floatermsend('mvnd clean verify') end,
        { buffer = bufnr, desc = 'mvn clean verify' })
    map(modes.n, '<leader>mp', function() floaterm.floatermsend('mvnd clean package -DskipTests=true') end,
        { buffer = bufnr, desc = 'mvn package (no tests)' })
    map(modes.n, '<leader>mv', function() floaterm.floatermsend('mvnd verify') end,
        { buffer = bufnr, desc = 'mvn verify' })
end

local function find_project_root()
    if vim.g.jdtls_project_root ~= nil then
        return vim.g.jdtls_project_root
    end

    -- always assume a git project; this works better with multimodule projects
    return require('jdtls.setup').find_root({ '.git' })
end

function This.jdtls_config()
    local location = vim.fn.stdpath('data') .. '/mason/packages/jdtls'
    local jdtls_bundles = {
        vim.fn.glob(
            '~/bin/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar')
    }
    vim.list_extend(jdtls_bundles, vim.split(
        vim.fn.glob('~/bin/vscode-java-test/server/*.jar'), '\n'))

    return {
        cmd = {
            'jdtls.sh',
            location .. '/bin',
            location,
            vim.env.HOME .. '/.vim/jdtls/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
        },
        init_options = { bundles = jdtls_bundles },
        root_dir = find_project_root(),
        capabilities = require('util.lsp').cmp_capabilities,
        handlers = {
            -- To avoid annoying 'Press Enter to continue' messages while downloading dependencies
            ['language/status'] = function(_, result)
                local msg = result.message
                local c = vim.o.columns
                if #msg > c then
                    msg = msg:sub(1, c - 1) .. '…'
                end
                vim.cmd.echo('"' .. msg .. '"')
            end
        },
        settings = {
            java = {
                use_lombok_agent = true,
                format = { enabled = false },
                signatureHelp = { enabled = true },
                completion = {
                    favoriteStaticMembers = {
                        'io.restassured.RestAssured.*',
                        'java.util.Objects.requireNonNull',
                        'java.util.Objects.requireNonNullElse',
                        'org.hamcrest.CoreMatchers.*',
                        'org.hamcrest.Matchers.*',
                        'org.junit.jupiter.api.Assertions.*',
                        'org.mockito.Mockito.*'
                    },
                    filteredTypes = {
                        'com.sun.*',
                        'java.awt.*',
                        'jdk.*',
                        'sun.*'
                    }
                }
            }
        },
        on_attach = on_attach
    }
end

return This
