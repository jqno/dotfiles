return {
    'neovim/nvim-lspconfig',
    dependencies = {
        { 'folke/neodev.nvim', config = true }
    },
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
        local cmp_capabilities = require('cmp_nvim_lsp').default_capabilities()

        lspconfig.bashls.setup {
            capabilities = cmp_capabilities
        }

        lspconfig.gopls.setup {
            capabilities = cmp_capabilities
        }

        lspconfig.kotlin_language_server.setup {
            capabilities = cmp_capabilities
        }

        lspconfig.lemminx.setup {
            capabilities = cmp_capabilities,
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
            capabilities = cmp_capabilities,
            settings = { pylsp = { configurationSources = { 'flake8' } } }
        }

        lspconfig.lua_ls.setup {
            capabilities = cmp_capabilities,
            settings = {
                Lua = {
                    runtime = { version = 'LuaJIT' },
                    diagnostics = { globals = { 'vim', 'require' } },
                    telemetry = { enable = false }
                }
            }
        }

        lspconfig.tsserver.setup {
            capabilities = cmp_capabilities
        }

        require('util.autocmd').create('lsp_define_java', 'FileType', 'java', function()
            require('jdtls').start_or_attach(require('util.jdtls').jdtls_config(cmp_capabilities))
        end)
    end
}
