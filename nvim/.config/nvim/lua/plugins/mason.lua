return {
    'williamboman/mason.nvim',
    dependencies = {
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        'williamboman/mason-lspconfig.nvim',
    },

    config = function()
        require('mason').setup({
            ui = { border = 'rounded' }
        })
        require('mason-lspconfig').setup()
        require('mason-tool-installer').setup({
            ensure_installed = {
                -- LSP
                'bash-language-server',
                'gopls',
                'kotlin-language-server',
                'jdtls',
                'lemminx',
                'lua-language-server',
                'python-lsp-server',
                'typescript-language-server',

                -- Linters
                'actionlint',
                'flake8',
                'hadolint',
                'markdownlint',
                'shellcheck',
                'vale',

                -- Formatters
                'shellharden',
                'sql-formatter',
            }
        })
    end
}
