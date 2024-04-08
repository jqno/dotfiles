local map = vim.keymap.set
local modes = require('util.modes')

map(modes.n, '<leader>m<space>',
    function() require('plugins.floaterm').send('kscript ' .. vim.fn.expand('%:p') .. '') end,
    { buffer = true, desc = 'run with kscript' })
