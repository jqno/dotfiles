local This = {}

local wk = require('which-key').register

function This.setup()
    wk({
        ['<leader>m'] = {
            ['<space>'] = {
                '<cmd>lua require("util").floatermsend("kscript ' .. vim.fn.expand('%:p') .. '")<CR>',
                'run with kscript'
            },
        }
    })
end

return This
