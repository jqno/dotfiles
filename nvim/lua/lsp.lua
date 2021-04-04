local M = {}

local lsp = require'lspconfig'
local util = require'util'

local on_attach = function(client, bufnr)
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
      autocmd CursorHold <buffer> lua vim.lsp.diagnostic.show_line_diagnostics()
    ]])
  end
end

function M.setup()
  require('nlua.lsp.nvim').setup(lsp, {
    on_attach = on_attach
  })

  Jdtls_config = {
    on_attach = on_attach,
    cmd = { 'jdtls.sh' }
  }

  local metals_config = {
    on_attach = on_attach,
    init_options = {
      statusBarProvider = 'on'
    }
  }
  Metals_config = require("metals").bare_config
  for k,v in pairs(metals_config) do Metals_config[k] = v end

  util.augroup('lsp_define', [[
    autocmd FileType java lua require('jdtls').start_or_attach(Jdtls_config)
    autocmd FileType scala,sbt lua require('metals').initialize_or_attach(Metals_config)
  ]])
end

return M
