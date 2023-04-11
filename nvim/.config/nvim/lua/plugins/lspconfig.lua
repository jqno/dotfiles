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
        'yaml'
    },

    config = function()
        local lspconfig = require('lspconfig')
        local lsp = require('util.lsp')

        lspconfig.bashls.setup {
            capabilities = lsp.cmp_capabilities
        }

        lspconfig.gopls.setup {
            capabilities = lsp.cmp_capabilities
        }

        lspconfig.kotlin_language_server.setup {
            capabilities = lsp.cmp_capabilities
        }

        lspconfig.lemminx.setup {
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
            capabilities = lsp.cmp_capabilities,
            settings = { pylsp = { configurationSources = { 'flake8' } } }
        }

        lspconfig.lua_ls.setup {
            capabilities = lsp.cmp_capabilities,
            settings = { Lua = { runtime = { version = 'LuaJIT' }, diagnostics = { globals = { 'vim', 'require' } } } }
        }

        lspconfig.tsserver.setup {
            capabilities = lsp.cmp_capabilities
        }

        require('util.autocmd').create('lsp_define_java', 'FileType', 'java', function()
            require('jdtls').start_or_attach(require('util.jdtls').jdtls_config())
        end)
    end
}
