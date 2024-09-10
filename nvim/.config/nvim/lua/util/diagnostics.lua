local This = {}

This.enabled = true

function This.toggle_all()
    This.enabled = not This.enabled
    vim.diagnostic.config({
        signs = This.enabled,
        underline = This.enabled,
    })
end

return This
