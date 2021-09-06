local This = {}

local lsp = require('lspconfig')
local efm = require('lsp_efm')
local vim_util = require('vim-util')

local function clean_diagnostics()
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = false,
      underline = true,
      signs = true,
    }
  )
end

function This.on_attach(client, bufnr)
  require('mappings').setup_lsp(client, bufnr)

  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  clean_diagnostics()

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

local function on_attach_efm(client, bufnr)
  require('mappings').setup_lsp_diagnostics_and_formatting(client, bufnr)
  clean_diagnostics()
end

local function setup_lsp()
  lsp.pylsp.setup {
    on_attach = This.on_attach
  }

  lsp.sumneko_lua.setup {
    cmd = { 'lua-language-server' },
    on_attach = This.on_attach,
    settings = require('filetypes.lua').lsp_config
  }

  lsp.efm.setup {
    filetypes = { 'java', 'lua', 'markdown' },
    on_attach = on_attach_efm,
    init_options = { documentFormatting = true },
    settings = {
      rootMarkers = { '.git/' },
      languages = {
        java = { efm.format.prettier },
        lua = { efm.format.luaformat },
        markdown = { efm.lint.markdownlint, efm.format.prettier }
      }
    }
  }

  vim_util.augroup('lsp_define', [[
    autocmd FileType java lua require('jdtls').start_or_attach(require('filetypes.java').jdtls_config())
    autocmd FileType scala,sbt,sc lua require('metals').initialize_or_attach(require('filetypes.scala').metals_config())
  ]])
end

function This.setup()
  setup_lsp()
end

return This
