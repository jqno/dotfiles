local map = vim.keymap.set
local modes = require('util.modes')
local floaterm = require('plugins.floaterm')

map(modes.n, '<leader>m<space>',
    function() require('plugins.floaterm').send('scala ' .. vim.fn.expand('%:p') .. '') end,
    { buffer = true, desc = 'run with scala' })

map(modes.n, '<leader>ro', '<cmd>MetalsOrganizeImports<CR>', { buffer = true, desc = 'refactor: organize imports' })
map(modes.n, '<leader>mr', '<cmd>MetalsCompileClean<CR>', { buffer = true, desc = 'Metals clean compile' })
map(modes.n, '<leader>mcc', function() floaterm.send('sbt clean Test/compile') end,
    { buffer = true, desc = 'sbt clean compile' })
map(modes.n, '<leader>mcv', function() floaterm.send('sbt clean compile scalafmtCheckAll test') end,
    { buffer = true, desc = 'sbt clean verify' })
