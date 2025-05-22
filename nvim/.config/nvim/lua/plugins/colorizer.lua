return {
    'catgoose/nvim-colorizer.lua',
    ft = { 'css', 'html' },
    event = 'UIEnter',

    opts = {
        filetypes = { '!*' } -- Turn off by default
    }
}
