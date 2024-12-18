return {
    'vim-test/vim-test',
    cmd = { 'TestLast', 'TestFile', 'TestNearest' },
    dev = true,

    init = function()
        vim.g['test#custom_strategies'] = { shell_in_floaterm = require('plugins.floaterm').send }
        vim.g['test#strategy'] = 'shell_in_floaterm'
        vim.g['test#java#maventest#executable'] = require('util.java').mavenQuietExecutable
    end
}
