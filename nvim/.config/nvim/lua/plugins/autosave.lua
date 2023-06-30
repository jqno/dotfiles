return {
    'okuuva/auto-save.nvim',
    event = 'BufRead', -- load lazily to ensure the splash screen appears

    opts = {
        execution_message = {
            dim = 0.4,
            cleaning_interval = 1000
        },
        callbacks = {
            before_saving = function()
                local clients = vim.lsp.get_active_clients({ bufnr = 0 })
                if #clients > 0 and not vim.g.do_not_autoformat and vim.bo.modifiable then
                    print('smurf')
                    vim.lsp.buf.format()
                end
            end
        }
    }
}
