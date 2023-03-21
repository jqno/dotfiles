return {
    'neovim/nvim-lspconfig',
    ft = {
        'dockerfile',
        'go',
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
        local lsp = require('util.lsp')

        lspconfig.bashls.setup {
            on_attach = lsp.on_attach,
            capabilities = lsp.cmp_capabilities
        }

        lspconfig.gopls.setup {
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
            settings = {
                xml = {
                    fileAssociations = {
                        {
                            systemId = 'http://maven.apache.org/xsd/maven-4.0.0.xsd',
                            pattern = 'pom.xml'
                        }
                    }
                }
            }

        }

        lspconfig.pylsp.setup {
            on_attach = lsp.on_attach,
            capabilities = lsp.cmp_capabilities,
            settings = { pylsp = { configurationSources = { 'flake8' } } }
        }

        lspconfig.sumneko_lua.setup {
            on_attach = lsp.on_attach,
            capabilities = lsp.cmp_capabilities,
            settings = { Lua = { runtime = { version = 'LuaJIT' }, diagnostics = { globals = { 'vim', 'require' } } } }
        }

        lspconfig.tsserver.setup {
            on_attach = lsp.on_attach,
            capabilities = lsp.cmp_capabilities
        }

        require('util.autocmd').create('lsp_define_java', 'FileType', 'java', function()
            require('jdtls').start_or_attach(require('util.jdtls').jdtls_config())
        end)
    end
}
