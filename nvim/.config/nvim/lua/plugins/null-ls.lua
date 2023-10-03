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
            },
            on_attach = function(client, bufnr)
                -- require('config.mappings').setup_lsp_diagnostics_and_formatting(client, bufnr)
            end
        }
    end
}
