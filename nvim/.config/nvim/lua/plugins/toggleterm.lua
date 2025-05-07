return {
    'akinsho/toggleterm.nvim',
    event = 'UIEnter',

    opts = {
        direction = 'float',
        highlights = {
            FloatBorder = {
                link = 'FloatBorder'
            }
        },
        float_opts = {
            border = 'curved'
        }
    }
}
