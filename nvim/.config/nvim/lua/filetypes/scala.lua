local This = {}

function This.setup()
    local map = vim.keymap.set
    local modes = require('mappings').modes

    map(modes.n, '<leader>m<space>', function() require('util').floatermsend('scala ' .. vim.fn.expand('%:p') .. '') end,
        { buffer = true, desc = 'run with scala' })
end

return This
