local This = {}

function This.setup()
    vim.opt.wrap = true
    vim.opt.commentstring = '// %s'
end

return This
