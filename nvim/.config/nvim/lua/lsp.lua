local This = {}

local lsp = require('lspconfig')
local lsputil = require('lspconfig.util')
local efm = require('lsp_efm')
local vim_util = require('vim-util')
local rounded_border = require('settings').rounded_border

local function enhance_handler(name, original, enhancement)
    vim.lsp.handlers[name] = vim.lsp.with(original, enhancement)
end

local function clean_diagnostics()
    enhance_handler('textDocument/publishDiagnostics',
        vim.lsp.diagnostic.on_publish_diagnostics,
        { virtual_text = false, underline = true, signs = true })
end

function This.on_attach(client, bufnr)
    require('lsp-format').on_attach(client, bufnr)
    require('mappings').setup_lsp(client, bufnr)

    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    enhance_handler('textDocument/hover', vim.lsp.handlers.hover, rounded_border)
    enhance_handler('textDocument/signatureHelp',
        vim.lsp.handlers.signature_help, rounded_border)

    clean_diagnostics()

    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_create_augroup('lsp_attach', { clear = true })
        vim.api.nvim_create_autocmd('CursorHold',
            { group = 'lsp_attach', pattern = '<buffer>', callback = vim.lsp.buf.document_highlight })
        vim.api.nvim_create_autocmd('CursorMoved',
            { group = 'lsp_attach', pattern = '<buffer>', callback = vim.lsp.buf.clear_references })
    end
end

local function on_attach_efm(client, bufnr)
    require('lsp-format').on_attach(client, bufnr)
    require('mappings').setup_lsp_diagnostics_and_formatting(client, bufnr)
    clean_diagnostics()
end

This.cmp_capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local function setup_lsp()

    lsp.pylsp.setup {
        on_attach = This.on_attach,
        capabilities = This.cmp_capabilities,
        settings = require('filetypes.python').lsp_config
    }

    lsp.lemminx.setup {
        on_attach = This.on_attach,
        capabilities = This.cmp_capabilities,
        settings = require('filetypes.xml').lsp_config
    }

    lsp.sumneko_lua.setup {
        cmd = { 'lua-language-server' },
        on_attach = This.on_attach,
        capabilities = This.cmp_capabilities,
        settings = require('filetypes.lua').lsp_config
    }

    lsp.efm.setup {
        filetypes = efm.filetypes,
        root_dir = function(fname)
            return lsputil.find_git_ancestor(fname) or
                lsputil.root_pattern('.')(fname)
        end,
        on_attach = on_attach_efm,
        capabilities = This.cmp_capabilities,
        init_options = { documentFormatting = true },
        settings = efm.settings
    }

    vim_util.augroup('lsp_define_java', 'FileType', 'java',
        function() require('jdtls').start_or_attach(require('filetypes.java').jdtls_config()) end)
    vim_util.augroup('lsp_define_scala', 'FileType', 'scala,sbt,sc',
        function() require('metals').initialize_or_attach(require('filetypes.scala').metals_config()) end)
end

function This.setup()
    setup_lsp()
end

return This
