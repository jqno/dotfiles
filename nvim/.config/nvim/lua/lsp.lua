local This = {}

local lsp = require('lspconfig')
local efm = require('lsp_efm')
local vim_util = require('vim-util')

local function clean_diagnostics()
    vim.lsp.handlers["textDocument/publishDiagnostics"] =
        vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
                     {virtual_text = false, underline = true, signs = true})
end

function This.on_attach(client, bufnr, skip_code_actions)
    require('mappings').setup_lsp(client, bufnr, skip_code_actions)

    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    clean_diagnostics()

    if client.resolved_capabilities.document_highlight then
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

This.cmp_capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp
                                                                        .protocol
                                                                        .make_client_capabilities())

local function setup_lsp()

    lsp.pylsp.setup {
        on_attach = This.on_attach,
        capabilities = This.cmp_capabilities,
        settings = require('filetypes.python').lsp_config
    }

    lsp.sumneko_lua.setup {
        cmd = {'lua-language-server'},
        on_attach = This.on_attach,
        capabilities = This.cmp_capabilities,
        settings = require('filetypes.lua').lsp_config
    }

    lsp.efm.setup {
        filetypes = efm.filetypes,
        on_attach = on_attach_efm,
        capabilities = This.cmp_capabilities,
        init_options = {documentFormatting = true},
        settings = efm.settings
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
