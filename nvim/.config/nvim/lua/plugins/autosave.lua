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
            group = vim.api.nvim_create_augroup('AutoSaveAndAutoFormat', { clear = true }),
            pattern = 'AutoSaveWritePost',
            callback = function(opts)
                if opts.data.saved_buffer ~= nil and (vim.g.do_autoformat or vim.b[opts.data.saved_buffer].do_autoformat) then
                    require('conform').format({ lsp_fallback = true })
                end
            end
        })
    end
}
