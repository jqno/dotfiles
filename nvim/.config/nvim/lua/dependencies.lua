local This = {}

function This.setup()
    require('mason-tool-installer').setup({
        ensure_installed = {
            -- LSP
            'efm',
            'jdtls',
            'lemminx',
            'lua-language-server',
            'python-lsp-server',

            -- Linters
            'flake8',
            'markdownlint',
            'shellcheck',
            'vale'
        }
    })
end

return This
