local This = {}

function This.setup()
    vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost' }, {
        group = vim.api.nvim_create_augroup('AutoFormat', { clear = true }),
        pattern = '*',
        callback = function()
            local bufnr = 0
            local clients = vim.lsp.get_active_clients({ bufnr = bufnr })
            if #clients > 0 and not vim.g.do_not_autoformat and vim.api.nvim_buf_get_option(bufnr, 'modifiable') then
                vim.lsp.buf.format({ bufnr = bufnr })
            end
        end
    })
end

return This
