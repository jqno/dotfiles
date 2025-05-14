local ensure_installed = {
    -- LSP
    'bash-language-server',
    'harper-ls',
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
    'mypy',
    'shellcheck',
    'vale',

    -- Formatters
    'shellharden',
    'sql-formatter',
}

local function lsp_java_config(capabilities)
    vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('lsp_define_java', { clear = true }),
        pattern = 'java',
        callback = function()
            require('jdtls').start_or_attach(require('plugins.jdtls').jdtls_config(capabilities))
        end
    })
end

local function lsp_scala_config(capabilities)
    vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('lsp_define_scala', { clear = true }),
        pattern = 'scala',
        callback = function()
            require('metals').initialize_or_attach(require('plugins.metals').metals_config(capabilities))
        end
    })
end

local function on_lsp_attach(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    require('config.mappings').setup_lsp(bufnr)

    if client ~= nil and client.server_capabilities.documentHighlightProvider then
        local highlight_group = vim.api.nvim_create_augroup('LspHighlightReferences', { clear = false })
        vim.api.nvim_create_autocmd({ 'CursorHold' }, {
            group = highlight_group,
            buffer = args.buf,
            callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ 'CursorMoved', 'ModeChanged' }, {
            group = highlight_group,
            buffer = args.buf,
            callback = vim.lsp.buf.clear_references,
        })
    end
end

return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'mason-org/mason.nvim',
        'mason-org/mason-lspconfig.nvim',
        'WhoIsSethDaniel/mason-tool-installer.nvim'
    },

    config = function()
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

        require('mason').setup({ ui = { border = 'rounded' } })
        require('mason-tool-installer').setup({ ensure_installed = ensure_installed })
        require('mason-lspconfig').setup({
            automatic_enable = {
                exclude = { 'jdtls', 'metals' }
            },
            ensure_installed = {}
        })

        lsp_java_config(capabilities)
        lsp_scala_config(capabilities)

        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('LspAttachGroup', { clear = true }),
            callback = on_lsp_attach
        })
    end
}
