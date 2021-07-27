local This = {}

local lsp = require('lspconfig')
local lspinstall = require('lspinstall')
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

local function make_config()
  return {
    on_attach = This.on_attach
  }
end

local function setup_lsp()
  lspinstall.setup()

  local servers = lspinstall.installed_servers()
  for _, server in pairs(servers) do
    local config = make_config()

    if server == 'lua' then
      config.settings = require('filetypes.lua').lsp_config
    end

    if server ~= 'java' and server ~= 'scala' then
      lsp[server].setup(config)
    end
  end

  vim_util.augroup('lsp_define', [[
    autocmd FileType java lua require('jdtls').start_or_attach(require('filetypes.java').jdtls_config())
    autocmd FileType scala,sbt,sc lua require('metals').initialize_or_attach(require('filetypes.scala').metals_config())
  ]])
end

local function setup_lspinstall_hook()
  require('lspinstall').post_install_hook = function()
    setup_lsp()
    vim.cmd('bufdo e')
  end
end

function This.setup()
  setup_lsp()
  setup_lspinstall_hook()
end

return This
