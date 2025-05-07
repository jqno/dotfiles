local map = vim.keymap.set
local modes = require('util.modes')
local terminal = require('util.terminal')

vim.opt_local.formatoptions:remove('o')

map(modes.n, '<leader>m<space>',
    function() terminal.send('scala ' .. vim.fn.expand('%:p') .. '') end,
    { buffer = true, desc = 'run with scala' })

map(modes.n, '<leader>ro', '<cmd>MetalsOrganizeImports<CR>', { buffer = true, desc = 'refactor: organize imports' })
map(modes.n, '<leader>mr', '<cmd>MetalsCompileClean<CR>', { buffer = true, desc = 'Metals clean compile' })
map(modes.n, '<leader>mCC', function() terminal.send('sbt clean Test/compile') end,
    { buffer = true, desc = 'sbt clean compile' })
map(modes.n, '<leader>mcc', function() terminal.send('sbt Test/compile') end,
    { buffer = true, desc = 'sbt compile' })
map(modes.n, '<leader>mv', function() terminal.send('sbt compile scalafmtCheckAll testOnlyUnit') end,
    { buffer = true, desc = 'sbt verify' })
map(modes.n, '<leader>mCv', function() terminal.send('sbt clean compile scalafmtCheckAll test') end,
    { buffer = true, desc = 'sbt verify' })

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('LspAttachScala', { clear = true }),
    buffer = 0,
    callback = function()
        vim.lsp.codelens.refresh()
    end
})
