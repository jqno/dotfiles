local This = {}

function This.setup()
    require('mason-tool-installer').setup({
        ensure_installed = {
            -- LSP
            'bash-language-server',
            'jdtls',
            'lemminx',
            'lua-language-server',
            'python-lsp-server',

            -- Linters
            'flake8',
            'hadolint',
            'markdownlint',
            'shellcheck',
            'vale',

            -- Formatters
            'shellharden'
        }
    })
end

return This
