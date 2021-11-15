local This = {}

local wk = require('which-key').register
local dap = require('dap')
local jdtls = require('jdtls')
local util = require('util')

function This.setup()
    util.set_buf_indent(4)
end

function This.dap_run_test()
    dap.repl.open()
    jdtls.test_class()
end

function This.dap_run_test_nearest()
    dap.repl.open()
    jdtls.test_nearest_method()
end

function This.jdtls_config()
    local jdtls_bundles = {
        vim.fn.glob(
            "~/bin/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar")
    }
    vim.list_extend(jdtls_bundles, vim.split(
                        vim.fn.glob("~/bin/vscode-java-test/server/*.jar"), "\n"))

    return {
        cmd = {
            'jdtls.sh',
            vim.env.HOME .. '/.jdtls/' ..
                vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
        },
        init_options = {bundles = jdtls_bundles},
        root_dir = require('jdtls.setup').find_root({'pom.xml', 'gradle.build'}),
        capabilities = require('lsp').cmp_capabilities,
        on_attach = function(client, bufnr)
            require('lsp').on_attach(client, bufnr, true)

            require('jdtls.setup').add_commands()
            require('jdtls').setup_dap({hotcodereplace = 'auto'})
            require('jdtls.dap').setup_dap_main_class_configs()
            require('mappings').setup_dap(bufnr)

            local modes = require('mappings').modes

            client.resolved_capabilities.document_formatting = false

            wk({
                ['<leader>d'] = {
                    r = {'<cmd>lua require("dap").continue()<CR>', 'run'},
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
                    ['<CR>'] = {
                        '<cmd>lua require("jdtls").code_action()<CR>',
                        'Java code actions'
                    },
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
                    r = {
                        '<cmd>lua require("jdtls").update_project_config()<CR>',
                        'reload'
                    }
                }
            }, {buffer = bufnr})

            wk({
                ['<leader>r'] = {
                    j = {
                        '<cmd>lua require("jdtls").code_action(true)<CR>',
                        'Java code actions'
                    },
                    m = {
                        '<cmd>lua require("jdtls").extract_method(true)<CR>',
                        'extract method'
                    },
                    v = {
                        '<cmd>lua require("jdtls").extract_variable(true)<CR>',
                        'extract variable'
                    }
                }
            }, {buffer = bufnr, mode = modes.v})
        end
    }
end

return This
