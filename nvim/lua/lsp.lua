local This = {}

local lsp = require('lspconfig')
local vim_util = require('vim-util')

function This.on_attach(client, bufnr)
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
    vim_util.highlight_link('LspReferenceRead', 'DiffAdd')
    vim_util.highlight_link('LspReferenceWrite', 'DiffDelete')
    vim_util.highlight('LspReferenceText', nil, nil, 'italic')

    vim_util.augroup('lsp_attach', [[
      autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    ]])
  end
end

local function setup_lsp()
  require('nlua.lsp.nvim').setup(lsp, {
    on_attach = This.on_attach
  })

  vim_util.augroup('lsp_define', [[
    autocmd FileType java lua require('jdtls').start_or_attach(require('filetypes.java').jdtls_config())
    autocmd FileType scala,sbt,sc lua require('metals').initialize_or_attach(require('filetypes.scala').metals_config())
  ]])
end

local function setup_lspsaga()
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
end

function This.setup()
  setup_lsp()
  setup_lspsaga()
end

return This
