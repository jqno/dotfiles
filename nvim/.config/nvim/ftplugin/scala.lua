local map = vim.keymap.set
local modes = require('util.modes')

map(modes.n, '<leader>m<space>',
    function() require('util.floaterm').floatermsend('scala ' .. vim.fn.expand('%:p') .. '') end,
    { buffer = true, desc = 'run with scala' })

map(modes.n, '<leader>ro', '<cmd>MetalsOrganizeImports<CR>', { buffer = true, desc = 'refactor: organize imports' })
map(modes.n, '<leader>mr', '<cmd>MetalsCompileClean<CR>', { buffer = true, desc = 'clean compile' })
