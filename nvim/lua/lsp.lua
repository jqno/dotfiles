local M = {}

local dap = require('dap')
local lsp = require('lspconfig')
local util = require('util')


function M.dap_run(config)
  dap.repl.open()
  dap.run(config)
end

function M.dap_run_scala_run()
  M.dap_run({
    type = 'scala',
    request = 'launch',
    name = 'Run',
    metalsRunType = 'run'
  })
end

function M.dap_run_scala_test()
  M.dap_run({
    type = 'scala',
    request = 'launch',
    name = 'Test File',
    metalsRunType = 'testFile'
  })
end

function M.dap_run_java_test_class()
  dap.repl.open()
  require('jdtls').test_class()
end

function M.dap_run_java_test_nearest()
  dap.repl.open()
  require('jdtls').test_nearest_method()
end

local function on_attach(client, bufnr)
  require('mappings').setup_lsp(client, bufnr)

  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = false,
      underline = true,
      signs = true,
    }
  )

  if client.resolved_capabilities.document_highlight then
    util.highlight_link('LspReferenceRead', 'DiffAdd')
    util.highlight_link('LspReferenceWrite', 'DiffDelete')
    util.highlight('LspReferenceText', nil, nil, 'italic')

    util.augroup('lsp_attach', [[
      autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    ]])
  end
end

function M.setup()
  local mappings = require('mappings').consts()
  local buf_map = util.buf_map
  local modes = require('mappings').modes

  require('nlua.lsp.nvim').setup(lsp, {
    on_attach = on_attach
  })

  require('lspsaga').init_lsp_saga({
    use_saga_diagnostic_sign = false,
    error_sign = '✗',
    warn_sign = '◆',
    hint_sign = 'H',
    infor_sign = 'i',
    code_action_icon = '·',
    code_action_prompt = { sign_priority = 1, virtual_text = false },
    code_action_keys = { quit = '<Esc>' },
    finder_action_keys = { quit = '<Esc>' },
    rename_action_keys = { quit = '<Esc>' },
    border_style = 2
  })

  local jdtls_bundles = {
    vim.fn.glob("~/bin/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar"),
  }
  vim.list_extend(jdtls_bundles, vim.split(vim.fn.glob("~/bin/vscode-java-test/server/*.jar"), "\n"))
  Jdtls_config = {
    cmd = { 'jdtls.sh', vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t') },
    init_options = {
      bundles = jdtls_bundles
    },
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)

      require('jdtls.setup').add_commands()
      require('jdtls').setup_dap()
      require('mappings').setup_dap(bufnr)

      buf_map(bufnr, modes.n, mappings.debug_run, '<cmd>lua require("dap").continue()<CR>')
      buf_map(bufnr, modes.n, mappings.debug_test, '<cmd>lua require("lsp").dap_run_java_test_class()<CR>')
      buf_map(bufnr, modes.n, mappings.debug_test_nearest, '<cmd>lua require("lsp").dap_run_java_test_nearest()<CR>')

      buf_map(bufnr, modes.n, mappings.refactor_code_action, '<cmd>lua require("jdtls").code_action()<CR>')
      buf_map(bufnr, modes.v, mappings.refactor_code_action, '<cmd>lua require("jdtls").code_action(true)<CR>')
      buf_map(bufnr, modes.v, mappings.refactor_menu, '<cmd>lua require("jdtls").code_action(false, "refactor")<CR>')

      buf_map(bufnr, modes.n, mappings.refactor_extract_variable, '<cmd>lua require("jdtls").extract_variable()<CR>')
      buf_map(bufnr, modes.v, mappings.refactor_extract_variable, '<cmd>lua require("jdtls").extract_variable(true)<CR>')
      buf_map(bufnr, modes.v, mappings.refactor_extract_method, '<cmd>lua require("jdtls").extract_method(true)<CR>')

      buf_map(bufnr, modes.n, mappings.refactor_organize_imports, '<cmd>lua require("jdtls").organize_imports()<CR>')
      buf_map(bufnr, modes.n, mappings.make_rebuild, '<cmd>lua require("jdtls").update_project_config()<CR>')
    end,
  }

  local metals_config = {
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)

      require('metals').setup_dap()
      require('mappings').setup_dap(bufnr)

      buf_map(bufnr, modes.n, mappings.debug_run, '<cmd>lua require("lsp").dap_run_scala_run()<CR>')
      buf_map(bufnr, modes.n, mappings.debug_test, '<cmd>lua require("lsp").dap_run_scala_test()<CR>')
      buf_map(bufnr, modes.n, mappings.refactor_organize_imports, '<cmd>MetalsOrganizeImports<CR>')
      buf_map(bufnr, modes.n, mappings.make_rebuild, '<cmd>MetalsCompileClean<CR>')
    end,
    init_options = {
      showImplicitArguments = true,
      showImplicitConversionsAndClasses = true,
      showInferredType = true,
      statusBarProvider = 'on'
    }
  }
  Metals_config = require("metals").bare_config
  for k,v in pairs(metals_config) do Metals_config[k] = v end

  util.augroup('lsp_define', [[
    autocmd FileType java lua require('jdtls').start_or_attach(Jdtls_config)
    autocmd FileType scala,sbt,sc lua require('metals').initialize_or_attach(Metals_config)
  ]])
end

return M
