local M = {}
local dap = require('dap')

local function dap_run(config)
  dap.repl.open()
  dap.run(config)
end

function M.dap_run()
  dap_run({
    type = 'scala',
    request = 'launch',
    name = 'Run',
    metalsRunType = 'run'
  })
end

function M.dap_run_test()
  dap_run({
    type = 'scala',
    request = 'launch',
    name = 'Test File',
    metalsRunType = 'testFile'
  })
end

return M

