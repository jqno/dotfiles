local This = {}

local wk = require('which-key').register
local dap = require('dap')

local function dap_run(config)
    dap.repl.open()
    dap.run(config)
end

function This.dap_run()
    dap_run({
        type = 'scala',
        request = 'launch',
        name = 'Run',
        metals = {runType = "run"}
    })
end

function This.dap_run_test()
    dap_run({
        type = 'scala',
        request = 'launch',
        name = 'Test File',
        metals = {runType = "run"}
    })
end

function This.metals_config()
    local metals_config = {
        on_attach = function(client, bufnr)
            require('lsp').on_attach(client, bufnr)

            require('metals').setup_dap()
            require('mappings').setup_dap(bufnr)

            wk({
                ['<leader>d'] = {
                    r = {
                        '<cmd>lua require("filetypes.scala").dap_run()<CR>',
                        'run'
                    },
                    t = {
                        '<cmd>lua require("filetypes.scala").dap_run_test()<CR>',
                        'test'
                    }
                },
                ['<leader>r'] = {
                    o = {'<cmd>MetalsOrganizeImports<CR>', 'organize imports'}
                },
                ['<leader>m'] = {r = {'<cmd>MetalsCompileClean<CR>', 'rebuild'}}
            })
        end,
        init_options = {
            showImplicitArguments = true,
            showImplicitConversionsAndClasses = true,
            showInferredType = true,
            statusBarProvider = 'on'
        }
    }

    local merged = require("metals").bare_config
    for k, v in pairs(metals_config) do
        merged[k] = v
    end

    return merged
end

return This

