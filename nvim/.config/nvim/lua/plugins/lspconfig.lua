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
                require('jdtls').start_or_attach(require('plugins.jdtls').jdtls_config(cmp_capabilities))
            end
        })

        vim.api.nvim_create_autocmd('FileType', {
            group = vim.api.nvim_create_augroup('lsp_define_scala', { clear = true }),
            pattern = 'scala',
            callback = function()
                require('metals').initialize_or_attach(require('plugins.metals').metals_config(cmp_capabilities))
            end
        })

        local function enhance_handler(name, original, enhancement)
            vim.lsp.handlers[name] = vim.lsp.with(original, enhancement)
        end

        vim.api.nvim_create_augroup('LspAttachGroup', { clear = true })
        vim.api.nvim_create_autocmd('LspAttach', {
            group = 'LspAttachGroup',
            callback = function(args)
                local bufnr = args.buf
                local client = vim.lsp.get_client_by_id(args.data.client_id)

                require('config.mappings').setup_lsp(bufnr)

                vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

                enhance_handler('textDocument/hover', vim.lsp.handlers.hover, { border = 'rounded' })
                enhance_handler('textDocument/signatureHelp',
                    vim.lsp.handlers.signature_help, { border = 'rounded' })

                if client.server_capabilities.documentHighlightProvider then
                    vim.api.nvim_create_augroup('lsp_attach', { clear = false })
                    vim.api.nvim_clear_autocmds({ buffer = bufnr, group = 'lsp_attach' })
                    vim.api.nvim_create_autocmd('CursorHold',
                        { group = 'lsp_attach', buffer = bufnr, callback = vim.lsp.buf.document_highlight })
                    vim.api.nvim_create_autocmd({ 'CursorMoved', 'ModeChanged' },
                        { group = 'lsp_attach', buffer = bufnr, callback = vim.lsp.buf.clear_references })
                end
            end
        })
    end
}
