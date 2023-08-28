local This = {}

function This.centered(fn)
    return function()
        fn()
        vim.cmd.norm('zz')
    end
end

return This
