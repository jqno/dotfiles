local M = {}

local lsp = require'lspconfig'

local on_attach = function(client, bufnr)
  require('mappings').setup_lsp(client, bufnr)

  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi link LspReferenceRead DiffAdd
      hi link LspReferenceWrite DiffDelete
      hi LspReferenceText gui=italic
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
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

  vim.api.nvim_exec([[
    augroup lsp
      autocmd!
      autocmd FileType java lua require('jdtls').start_or_attach(Jdtls_config)
      autocmd FileType scala,sbt lua require('metals').initialize_or_attach(Metals_config)
    augroup end
  ]], false)
end

return M
