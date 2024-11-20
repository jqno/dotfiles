return {
    '3rd/image.nvim',
    build = false,
    ft = { 'markdown' },

    opts = {
        processor = 'magick_cli',
        integrations = {
            markdown = {
                clear_in_insert_mode = true
            }
        }
    }
}
