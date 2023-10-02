return {
    'jose-elias-alvarez/null-ls.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim'
    },
    ft = require('plugins.lspconfig').ft,

    opts = function()
        local source = require('null-ls').builtins
        return {
            debug = true,
            sources = {
                source.diagnostics.actionlint,
                source.diagnostics.hadolint,
                source.diagnostics.markdownlint.with({
                    diagnostics_postprocess = function(diagnostic)
                        diagnostic.severity = vim.diagnostic.severity["INFO"]
                    end
                }),
                source.diagnostics.vale.with({
                    diagnostics_postprocess = function(diagnostic)
                        diagnostic.severity = vim.diagnostic.severity["HINT"]
                    end
                })
            },
            on_attach = function(client, bufnr)
                require('config.mappings').setup_lsp_diagnostics_and_formatting(client, bufnr)
            end
        }
    end
}
