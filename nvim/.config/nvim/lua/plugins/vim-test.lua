return {
    'vim-test/vim-test',

    init = function()
        vim.g['test#custom_strategies'] = { shell_in_floaterm = require('util').floatermsend }
        vim.g['test#strategy'] = 'shell_in_floaterm'
        vim.g['test#java#maventest#executable'] = 'mvnd'
    end
}
