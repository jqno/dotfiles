return {
    'okuuva/auto-save.nvim',
    event = 'BufRead', -- load lazily to ensure the splash screen appears

    config = function()
        require('auto-save').setup({
            execution_message = {
                dim = 0.5,
                cleaning_interval = 1000
            },
            trigger_events = {
                defer_save = { 'CursorHold' }
            }
        })

        vim.api.nvim_create_autocmd('User', {
            group = vim.api.nvim_create_augroup('AutoFormatOnAutoSave', { clear = true }),
            pattern = 'AutoSaveWritePre',
            callback = function(opts)
                local bufnr = opts.data.saved_buffer
                if bufnr ~= nil then
                    local clients = vim.lsp.get_active_clients({ bufnr = bufnr })
                    if #clients > 0 and not vim.g.do_not_autoformat and vim.api.nvim_buf_get_option(bufnr, 'modifiable') then
                        vim.lsp.buf.format({ bufnr = bufnr })
                    end
                end
            end
        })
    end
}
