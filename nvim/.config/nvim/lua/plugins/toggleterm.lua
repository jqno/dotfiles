return {
    'akinsho/toggleterm.nvim',
    event = 'UIEnter',

    opts = {
        direction = 'float',
        size = function(term)
            if term.direction == 'horizontal' then
                return 15
            else
                return vim.o.columns * 0.4
            end
        end,
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
