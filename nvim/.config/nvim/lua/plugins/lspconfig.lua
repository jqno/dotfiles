return {
    'neovim/nvim-lspconfig',
    ft = {
        'dockerfile',
        'java',
        'javascript',
        'kotlin',
        'lua',
        'markdown',
        'python',
        'sh',
        'sql',
        'typescript',
        'xml',
    },

    config = function()
        local lspconfig = require('lspconfig')
        local lsp = require('lsp')

        lspconfig.bashls.setup {
            on_attach = lsp.on_attach,
            capabilities = lsp.cmp_capabilities
        }

        lspconfig.kotlin_language_server.setup {
            on_attach = lsp.on_attach,
            capabilities = lsp.cmp_capabilities
        }

        lspconfig.lemminx.setup {
            on_attach = lsp.on_attach,
            capabilities = lsp.cmp_capabilities,
            settings = require('filetypes.xml').lsp_config
        }

        lspconfig.pylsp.setup {
            on_attach = lsp.on_attach,
            capabilities = lsp.cmp_capabilities,
            settings = require('filetypes.python').lsp_config
        }

        lspconfig.sumneko_lua.setup {
            on_attach = lsp.on_attach,
            capabilities = lsp.cmp_capabilities,
            settings = require('filetypes.lua').lsp_config
        }

        lspconfig.tsserver.setup {
            on_attach = lsp.on_attach,
            capabilities = lsp.cmp_capabilities
        }

        require('vim-util').augroup('lsp_define_java', 'FileType', 'java', function()
            require('jdtls').start_or_attach(require('filetypes.java').jdtls_config())
        end)
    end
}
