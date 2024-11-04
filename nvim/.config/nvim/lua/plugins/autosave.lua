return {
    'okuuva/auto-save.nvim',
    event = 'BufRead', -- load lazily to ensure the splash screen appears

    config = function()
        require('auto-save').setup({
            trigger_events = {
                immediate_save = { 'InsertLeave' },
                defer_save = { 'CursorHold' }
            }
        })
    end
}
