local This = {}

local wk = require('which-key').register

function This.setup()
    wk({
        ['<leader>m'] = {
            ['<space>'] = {
                '<cmd>lua require("util").floatermsend("scala ' .. vim.fn.expand('%:p') .. '")<CR>',
                'run with scala'
            },
        }
    })
end

return This
