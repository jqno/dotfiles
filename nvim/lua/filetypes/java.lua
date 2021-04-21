local This = {}

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
    vim.fn.glob("~/bin/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar"),
  }
  vim.list_extend(jdtls_bundles, vim.split(vim.fn.glob("~/bin/vscode-java-test/server/*.jar"), "\n"))

  return {
    cmd = { 'jdtls.sh', vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t') },
    init_options = {
      bundles = jdtls_bundles
    },
    on_attach = function(client, bufnr)
      require('lsp').on_attach(client, bufnr)

      require('jdtls.setup').add_commands()
      require('jdtls').setup_dap()
      require('mappings').setup_dap(bufnr)

      local buf_map = require('vim-util').buf_map
      local mappings = require('mappings').mappings
      local modes = require('mappings').modes

      buf_map(bufnr, modes.n, mappings.debug.run,
          '<cmd>lua require("dap").continue()<CR>')
      buf_map(bufnr, modes.n, mappings.debug.test,
          '<cmd>lua require("filetypes.java").dap_run_test()<CR>')
      buf_map(bufnr, modes.n, mappings.debug.test_nearest,
          '<cmd>lua require("filetypes.java").dap_run_test_nearest()<CR>')

      buf_map(bufnr, modes.n, mappings.refactor.code_action,
          '<cmd>lua require("jdtls").code_action()<CR>')
      buf_map(bufnr, modes.v, mappings.refactor.code_action,
          '<cmd>lua require("jdtls").code_action(true)<CR>')
      buf_map(bufnr, modes.v, mappings.refactor.menu,
          '<cmd>lua require("jdtls").code_action(false, "refactor")<CR>')

      buf_map(bufnr, modes.n, mappings.refactor.extract_variable,
          '<cmd>lua require("jdtls").extract_variable()<CR>')
      buf_map(bufnr, modes.v, mappings.refactor.extract_variable,
          '<cmd>lua require("jdtls").extract_variable(true)<CR>')
      buf_map(bufnr, modes.v, mappings.refactor.extract_method,
          '<cmd>lua require("jdtls").extract_method(true)<CR>')

      buf_map(bufnr, modes.n, mappings.refactor.organize_imports,
          '<cmd>lua require("jdtls").organize_imports()<CR>')
      buf_map(bufnr, modes.n, mappings.make.rebuild,
          '<cmd>lua require("jdtls").update_project_config()<CR>')
    end,
  }
end

return This
