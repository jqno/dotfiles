return {
    'mfussenegger/nvim-dap',
    ft = { 'scala' },

    config = function()
        local dap = require('dap')
        dap.configurations.scala = {
            {
                type = 'scala',
                request = 'launch',
                name = 'Test file',
                metals = {
                    runType = 'runOrTestFile'
                }
            },
            {
                type = 'scala',
                request = 'launch',
                name = 'Test module',
                metals = {
                    runType = 'testTarget'
                }
            }
        }
    end
}
