local M = {}

local dap = require('dap')
local jdtls = require('jdtls')
local settings = require('settings')

function M.setup()
  settings.set_buf_indent(4)
end

function M.dap_run_test()
  dap.repl.open()
  jdtls.test_class()
end

function M.dap_run_test_nearest()
  dap.repl.open()
  jdtls.test_nearest_method()
end

return M
