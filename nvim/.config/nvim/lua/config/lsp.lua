This = {}

local function enhance_handler(name, original, enhancement)
    vim.lsp.handlers[name] = vim.lsp.with(original, enhancement)
end

function This.setup()
    vim.api.nvim_create_augroup('LspAttachGroup', { clear = true })
    vim.api.nvim_create_autocmd('LspAttach', {
        group = 'LspAttachGroup',
        callback = function(args)
            local bufnr = args.buf
            local client = vim.lsp.get_client_by_id(args.data.client_id)

            require('config.mappings').setup_lsp(client, bufnr)

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
    })
end

return This