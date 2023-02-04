return {
    'Pocco81/auto-save.nvim',

    config = function()
        local autosave = require('auto-save')
        autosave.setup({
            execution_message = {
                dim = 0.4,
                cleaning_interval = 1000
            }
        })

        -- disable and manually enable after a timeout to make sure the splash screen doesn't disappear
        autosave.off()
        vim.defer_fn(autosave.on, 100)
    end
}
