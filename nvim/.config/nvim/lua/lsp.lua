local This = {}

local function enhance_handler(name, original, enhancement)
    vim.lsp.handlers[name] = vim.lsp.with(original, enhancement)
end

function This.on_attach(client, bufnr)
    require('mappings').setup_lsp(client, bufnr)

    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    enhance_handler('textDocument/hover', vim.lsp.handlers.hover, { border = 'rounded' })
    enhance_handler('textDocument/signatureHelp',
        vim.lsp.handlers.signature_help, { border = 'rounded' })

    if client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_create_augroup('lsp_attach', { clear = false })
        vim.api.nvim_clear_autocmds({ buffer = bufnr, group = 'lsp_attach' })
        vim.api.nvim_create_autocmd('CursorHold',
            { group = 'lsp_attach', buffer = bufnr, callback = vim.lsp.buf.document_highlight })
        vim.api.nvim_create_autocmd('CursorMoved',
            { group = 'lsp_attach', buffer = bufnr, callback = vim.lsp.buf.clear_references })
    end
end

This.cmp_capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

return This
