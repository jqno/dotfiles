local map = vim.keymap.set
local modes = require('util.modes')

map(modes.n, '<leader>xx', '<Plug>RestNvim', { buffer = true, desc = 'execute REST request' })
map(modes.n, '<leader>x<CR>', '<Plug>RestNvimLast', { buffer = true, desc = 'execute previous REST request' })
