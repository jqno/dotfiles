local This = {}

function This.load()
    require('luasnip.loaders.from_lua').lazy_load({
        paths = { vim.fn.stdpath('config') .. '/lua/snippets' }
    })
end

function This.reload()
    This.load()
    print('Snippets reloaded')
end

return This
