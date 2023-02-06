return {
    'Pocco81/auto-save.nvim',
    event = 'BufRead', -- load lazily to ensure the splash screen appears

    opts = {
        execution_message = {
            dim = 0.4,
            cleaning_interval = 1000
        }
    }
}
