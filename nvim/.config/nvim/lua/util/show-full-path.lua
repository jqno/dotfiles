local This = {}

function This.show_full_path()
    print('Full path: [' .. vim.fn.expand('%') .. ']')
end

return This
