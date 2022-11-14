local This = {}

This.lsp_config = {
    Lua = { runtime = { version = 'LuaJIT' }, diagnostics = { globals = { 'vim', 'require' } } }
}

function This.setup()
    require('util').set_buf_indent(4, false)
end

return This
