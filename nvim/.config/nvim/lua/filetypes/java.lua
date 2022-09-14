local This = {}

local wk = require('which-key').register
local dap = require('dap')
local jdtls = require('jdtls')
local util = require('util')

function This.setup()
    util.set_buf_indent(4, false)
end

function This.dap_run_test()
    dap.repl.open()
    jdtls.test_class()
end

function This.dap_run_test_nearest()
    dap.repl.open()
    jdtls.test_nearest_method()
end

local function on_attach(client, bufnr)
    require('lsp').on_attach(client, bufnr)

    require('jdtls.setup').add_commands()
    require('jdtls').setup_dap({ hotcodereplace = 'auto' })
    require('jdtls.dap').setup_dap_main_class_configs()
    require('mappings').setup_dap(bufnr)

    client.resolved_capabilities.document_formatting = false

    local modes = require('mappings').modes

    wk({
        ['<leader>d'] = {
            r = { '<cmd>lua require("dap").continue()<CR>', 'run' },
            t = {
                '<cmd>lua require("filetypes.java").dap_run_test()<CR>',
                'test file'
            },
            n = {
                '<cmd>lua require("filetypes.java").dap_run_test_nearest()<CR>',
                'test nearest'
            }
        },
        ['<leader>r'] = {
            R = {
                '<cmd>lua require("jdtls").code_action(false, "refactor")<CR>',
                'menu'
            },
            o = {
                '<cmd>lua require("jdtls").organize_imports()<CR>',
                'organize imports'
            },
            v = {
                '<cmd>lua require("jdtls").extract_variable()<CR>',
                'extract variable'
            }
        },
        ['<leader>m'] = {
            ['<space>'] = {
                '<cmd>lua require("util").floatermsend("jbang ' .. vim.fn.expand('%:p') .. '")<CR>',
                'run with JBang'
            },
            r = {
                '<cmd>lua require("jdtls").update_project_config()<CR>',
                'reload'
            },
            cc = {
                '<cmd>lua require("util").floatermsend("mvn clean test-compile")<CR>',
                'mvn clean compile'
            },
            cv = {
                '<cmd>lua require("util").floatermsend("mvn clean verify")<CR>',
                'mvn clean verify'
            },
            p = {
                '<cmd>lua require("util").floatermsend("mvn clean package -DskipTests=true")<CR>',
                'mvn package (no tests)'
            },
            v = {
                '<cmd>lua require("util").floatermsend("mvn verify")<CR>',
                'mvn verify'
            },
        }
    }, { buffer = bufnr })

    wk({
        ['<leader>r'] = {
            m = {
                '<cmd>lua require("jdtls").extract_method(true)<CR>',
                'extract method'
            },
            v = {
                '<cmd>lua require("jdtls").extract_variable(true)<CR>',
                'extract variable'
            }
        }
    }, { buffer = bufnr, mode = modes.v })
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
            "~/bin/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar")
    }
    vim.list_extend(jdtls_bundles, vim.split(
        vim.fn.glob("~/bin/vscode-java-test/server/*.jar"), "\n"))

    return {
        cmd = {
            'jdtls.sh',
            location .. '/bin',
            location,
            vim.env.HOME .. '/.jdtls/' ..
                vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
        },
        init_options = { bundles = jdtls_bundles },
        root_dir = find_project_root(),
        capabilities = require('lsp').cmp_capabilities,
        handlers = {
            -- To avoid annoying "Press Enter to continue" messages while downloading dependencies
            ['language/status'] = function() end
        },
        settings = {
            java = {
                use_lombok_agent = true,
                format = { enabled = false },
                signatureHelp = { enabled = true },
                completion = {
                    favoriteStaticMembers = {
                        "io.restassured.RestAssured.*",
                        "java.util.Objects.requireNonNull",
                        "java.util.Objects.requireNonNullElse",
                        "org.hamcrest.CoreMatchers.*",
                        "org.hamcrest.Matchers.*",
                        "org.junit.jupiter.api.Assertions.*",
                        "org.mockito.Mockito.*"
                    },
                    filteredTypes = {
                        "com.sun.*",
                        "java.awt.*",
                        "jdk.*",
                        "sun.*"
                    }
                }
            }
        },
        on_attach = on_attach
    }
end

return This
