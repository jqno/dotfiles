local map = vim.keymap.set
local modes = require('util.modes')

map(modes.n, '<leader>m<space>',
    function() require('plugins.floaterm').send('python3 ' .. vim.fn.expand('%:p') .. '') end,
    { buffer = true, desc = 'run' })
