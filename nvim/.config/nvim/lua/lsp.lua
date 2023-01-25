local This = {}

local lsp = require('lspconfig')
local vim_util = require('vim-util')

local function setup_mason()
    require('mason').setup({
        ui = { border = 'rounded' }
    })
    require('mason-lspconfig').setup()
end

local function enhance_handler(name, original, enhancement)
    vim.lsp.handlers[name] = vim.lsp.with(original, enhancement)
end

function This.on_attach(client, bufnr)
    require('mappings').setup_lsp(client, bufnr)

    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    enhance_handler('textDocument/hover', vim.lsp.handlers.hover, { border = 'rounded' })
    enhance_handler('textDocument/signatureHelp',
        vim.lsp.handlers.signature_help, { border = 'rounded' })

    if client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_create_augroup('lsp_attach', { clear = false })
        vim.api.nvim_clear_autocmds({ buffer = bufnr, group = 'lsp_attach' })
        vim.api.nvim_create_autocmd('CursorHold',
            { group = 'lsp_attach', buffer = bufnr, callback = vim.lsp.buf.document_highlight })
        vim.api.nvim_create_autocmd('CursorMoved',
            { group = 'lsp_attach', buffer = bufnr, callback = vim.lsp.buf.clear_references })
    end
end

This.cmp_capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

local function setup_lsp()

    lsp.bashls.setup {
        on_attach = This.on_attach,
        capabilities = This.cmp_capabilities
    }

    lsp.kotlin_language_server.setup {
        on_attach = This.on_attach,
        capabilities = This.cmp_capabilities
    }

    lsp.lemminx.setup {
        on_attach = This.on_attach,
        capabilities = This.cmp_capabilities,
        settings = require('filetypes.xml').lsp_config
    }

    lsp.pylsp.setup {
        on_attach = This.on_attach,
        capabilities = This.cmp_capabilities,
        settings = require('filetypes.python').lsp_config
    }

    lsp.sumneko_lua.setup {
        on_attach = This.on_attach,
        capabilities = This.cmp_capabilities,
        settings = require('filetypes.lua').lsp_config
    }

    lsp.tsserver.setup {
        on_attach = This.on_attach,
        capabilities = This.cmp_capabilities
    }

    vim_util.augroup('lsp_define_java', 'FileType', 'java', function()
        require('jdtls').start_or_attach(require('filetypes.java').jdtls_config())
    end)
end

local function setup_nullls()
    local nullls = require('null-ls')
    nullls.setup({
        debug = true,
        sources = {
            nullls.builtins.formatting.prettier.with({
                filetypes = { 'java', 'markdown' }
            }),
            nullls.builtins.formatting.shellharden,
            nullls.builtins.formatting.sql_formatter.with({
                args = { '--config', vim.env.HOME .. '/.sql-formatter.json', '$FILENAME' },
                filetypes = { 'sql' }
            }),
            nullls.builtins.diagnostics.hadolint,
            nullls.builtins.diagnostics.markdownlint.with({
                diagnostics_postprocess = function(diagnostic)
                    diagnostic.severity = vim.diagnostic.severity["INFO"]
                end
            }),
            nullls.builtins.diagnostics.vale.with({
                diagnostics_postprocess = function(diagnostic)
                    diagnostic.severity = vim.diagnostic.severity["HINT"]
                end
            })
        },
        on_attach = function(client, bufnr)
            require('mappings').setup_lsp_diagnostics_and_formatting(client, bufnr)
        end
    })
end

function This.setup()
    setup_mason()
    setup_lsp()
    setup_nullls()
end

return This
