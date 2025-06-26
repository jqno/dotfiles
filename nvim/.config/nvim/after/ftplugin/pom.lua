local map = vim.keymap.set
local modes = require('util.modes')
local terminal = require('util.terminal')

map(modes.n, '<leader>mcc', function() terminal.send('mvn clean test-compile') end,
    { buffer = true, desc = 'mvn clean compile' })
map(modes.n, '<leader>mcv', function() terminal.send('mvn clean verify') end,
    { buffer = true, desc = 'mvn clean verify' })
map(modes.n, '<leader>mp', function() terminal.send('mvn clean package -DskipTests=true') end,
    { buffer = true, desc = 'mvn package (no tests)' })
map(modes.n, '<leader>mv', function() terminal.send('mvn verify') end, { buffer = true, desc = 'mvn verify' })
