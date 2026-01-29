local This = {}

This.mavenIsQuiet = false
This.mavenQuietExecutable = 'noglob mvn -q'
This.mavenVerboseExecutable = 'noglob mvn'

function This.get_package()
    return This.get_package_for_language('java')
end

function This.get_package_for_language(lang)
    return vim.fn.expand('%:h'):match('src/.-/' .. lang .. '/(.*)'):gsub('/', '.')
end

function This.get_class()
    return vim.fn.expand('%'):match('src/.-/java/(.*).java'):gsub('/', '.')
end

function This.toggle_maven_quiet()
    This.mavenIsQuiet = not This.mavenIsQuiet
    if This.mavenIsQuiet then
        print('Maven is now quiet')
        vim.g['test#java#maventest#executable'] = This.mavenQuietExecutable
    else
        print('Maven is now verbose')
        vim.g['test#java#maventest#executable'] = This.mavenVerboseExecutable
    end
end

return This
