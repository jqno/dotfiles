local This = {}

function This.save_and_format()
    pcall(vim.cmd.write) -- continue if it doesn't work
    require('conform').format({ lsp_fallback = true })
end

return This
