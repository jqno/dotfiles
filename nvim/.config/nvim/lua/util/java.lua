local This = {}

function This.get_package()
    return vim.fn.expand('%:h'):match('src/.-/java/(.*)'):gsub('/', '.')
end

function This.get_class()
    return vim.fn.expand('%'):match('src/.-/java/(.*).java'):gsub('/', '.')
end

return This
