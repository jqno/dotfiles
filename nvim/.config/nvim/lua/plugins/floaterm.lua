return {
    'voldikss/vim-floaterm',
    event = 'VeryLazy',

    init = function()
        vim.g.floaterm_title = 'Terminal'
        vim.g.floaterm_wintype = 'float'
        vim.g.floaterm_height = 0.95
        vim.g.floaterm_width = 0.95
        vim.g.floaterm_borderchars = '─│─│╭╮╯╰'
    end
}
