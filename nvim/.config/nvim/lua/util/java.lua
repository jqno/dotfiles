local This = {}

function This.get_package()
    return This.get_package_for_language('java')
end

function This.get_package_for_language(lang)
    return vim.fn.expand('%:h'):match('src/.-/' .. lang .. '/(.*)'):gsub('/', '.')
end

function This.get_class()
    return vim.fn.expand('%'):match('src/.-/java/(.*).java'):gsub('/', '.')
end

return This
