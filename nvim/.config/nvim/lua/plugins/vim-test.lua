return {
    'vim-test/vim-test',
    cmd = { 'TestLast', 'TestFile', 'TestNearest' },

    init = function()
        vim.g['test#custom_strategies'] = { shell_in_terminal = require('util.terminal').send }
        vim.g['test#strategy'] = 'shell_in_terminal'
        vim.g['test#java#maventest#executable'] = require('util.java').mavenQuietExecutable
    end
}
