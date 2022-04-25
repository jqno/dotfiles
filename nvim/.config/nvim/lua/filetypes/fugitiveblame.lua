local This = {}

local modes = require('mappings').modes

function This.setup()
    -- I don't like the default binding for <CR> but I am too used to pressing it,
    -- so remapping it here to something I like better.
    vim.api.nvim_buf_set_keymap(0, modes.n, '<CR>', 'o', { noremap = false })
end

return This
