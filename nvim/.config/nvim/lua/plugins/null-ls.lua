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
                source.formatting.prettier.with({
                    filetypes = { 'java', 'markdown' }
                }),
                source.formatting.shellharden,
                source.formatting.sql_formatter.with({
                    args = { '--config', vim.env.HOME .. '/.sql-formatter.json', '$FILENAME' },
                    filetypes = { 'sql' }
                }),
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
                require('mappings').setup_lsp_diagnostics_and_formatting(client, bufnr)
            end
        }
    end
}
