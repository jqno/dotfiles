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

function M.metals_config()
  local metals_config = {
    on_attach = function(client, bufnr)
      require('lsp').on_attach(client, bufnr)

      require('metals').setup_dap()
      require('mappings').setup_dap(bufnr)

      local buf_map = require('vim-util').buf_map
      local mappings = require('mappings').mappings
      local modes = require('mappings').modes

      buf_map(bufnr, modes.n, mappings.debug.run,
          '<cmd>lua require("filetypes.scala").dap_run()<CR>')
      buf_map(bufnr, modes.n, mappings.debug.test,
          '<cmd>lua require("filetypes.scala").dap_run_test()<CR>')
      buf_map(bufnr, modes.n, mappings.refactor.organize_imports,
          '<cmd>MetalsOrganizeImports<CR>')
      buf_map(bufnr, modes.n, mappings.make.rebuild,
          '<cmd>MetalsCompileClean<CR>')
    end,
    init_options = {
      showImplicitArguments = true,
      showImplicitConversionsAndClasses = true,
      showInferredType = true,
      statusBarProvider = 'on'
    }
  }

  local merged = require("metals").bare_config
  for k,v in pairs(metals_config) do merged[k] = v end

  return merged
end

return M

