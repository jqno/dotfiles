local This = {}

This.lsp_config = {
  Lua = {
    diagnostics = {
      globals = { 'vim' }
    }
  }
}

function This.setup()
    require('util').set_buf_indent(4)
end

return This
