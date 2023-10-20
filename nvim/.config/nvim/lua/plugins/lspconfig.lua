return {
    'neovim/nvim-lspconfig',
    dependencies = {
        { 'folke/neodev.nvim', config = true }
    },
    ft = {
        'go',
        'java',
        'javascript',
        'kotlin',
        'lua',
        'python',
        'scala',
        'sh',
        'typescript',
        'xml',
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

        vim.api.nvim_create_autocmd('FileType', {
            group = vim.api.nvim_create_augroup('lsp_define_java', { clear = true }),
            pattern = 'java',
            callback = function()
                require('jdtls').start_or_attach(require('util.jdtls').jdtls_config(cmp_capabilities))
            end
        })

        vim.api.nvim_create_autocmd('FileType', {
            group = vim.api.nvim_create_augroup('lsp_define_scala', { clear = true }),
            pattern = 'scala',
            callback = function()
                require('metals').initialize_or_attach(require('util.metals').metals_config(cmp_capabilities))
            end
        })
    end
}
