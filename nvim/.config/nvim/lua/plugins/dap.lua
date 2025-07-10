return {
    'mfussenegger/nvim-dap',
    dependencies = {
        'rcarriga/nvim-dap-ui',
        'nvim-neotest/nvim-nio' -- dependency for nvim-dap-ui
    },
    ft = { 'java' },

    config = function()
        local dap = require('dap')
        local dapui = require('dapui')

        dapui.setup({
            layouts = {
                {
                    elements = {
                        {
                            id = 'scopes',
                            size = 0.5
                        },
                        {
                            id = 'stacks',
                            size = 0.5
                        }
                    },
                    position = 'left',
                    size = 40
                },
                {
                    elements = {
                        {
                            id = 'console',
                            size = 1
                        }
                    },
                    position = 'bottom',
                    size = 10
                }
            }
        })

        dap.configurations.scala = {
            {
                type = 'scala',
                request = 'launch',
                name = 'Test file',
                metals = {
                    runType = 'runOrTestFile'
                }
            }
        }

        dap.listeners.after.event_initialized['dapui_config'] = dapui.open
        dap.listeners.before.event_terminated['dapui_config'] = dapui.close
        dap.listeners.before.event_exited['dapui_config'] = dapui.close

        vim.fn.sign_define('DapBreakpoint', { text = '🛑', texthl = '', linehl = '', numhl = '' })
    end
}
