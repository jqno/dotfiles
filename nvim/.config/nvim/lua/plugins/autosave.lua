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
    end
}
