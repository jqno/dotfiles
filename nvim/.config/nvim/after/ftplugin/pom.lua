local map = vim.keymap.set
local modes = require('util.modes')
local floaterm = require('plugins.floaterm')

map(modes.n, '<leader>mcc', function() floaterm.send('mvnd clean test-compile') end,
    { buffer = true, desc = 'mvn clean compile' })
map(modes.n, '<leader>mcv', function() floaterm.send('mvnd clean verify') end,
    { buffer = true, desc = 'mvn clean verify' })
map(modes.n, '<leader>mp', function() floaterm.send('mvnd clean package -DskipTests=true') end,
    { buffer = true, desc = 'mvn package (no tests)' })
map(modes.n, '<leader>mv', function() floaterm.send('mvnd verify') end, { buffer = true, desc = 'mvn verify' })
