local This = {}

local dap = require('dap')

function This.if_debugging(debug_fn, fallback_char)
    if dap.session() then
        debug_fn()
    else
        vim.cmd('normal! ' .. fallback_char)
    end
end
return This
