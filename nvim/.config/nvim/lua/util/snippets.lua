local This = {}

function This.load()
    require('luasnip.loaders.from_vscode').lazy_load({
        paths = { vim.fn.stdpath('config') .. '/snippets' }
    })
end

function This.reload()
    This.load()
    print('Snippets reloaded')
end

return This
