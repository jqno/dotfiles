return {
    'voldikss/vim-floaterm',
    event = 'UIEnter',

    init = function()
        vim.g.floaterm_title = 'Terminal'
        vim.g.floaterm_wintype = require('util.screen-orientation').get_split()
        vim.g.floaterm_height = 0.4
        vim.g.floaterm_width = 0.4
    end,
}
