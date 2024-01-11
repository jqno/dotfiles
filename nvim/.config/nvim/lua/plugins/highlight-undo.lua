return {
    'tzachar/highlight-undo.nvim',
    event = 'UIEnter',

    opts = {
        undo = {
            hlgroup = 'IncSearch'
        },
        redo = {
            hlgroup = 'IncSearch'
        }
    }
}
