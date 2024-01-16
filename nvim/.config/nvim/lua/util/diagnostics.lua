local This = {}

This.disabled_all = {}

function This.toggle_all()
    local bufnr = vim.fn.bufnr()
    if This.disabled_all[bufnr] then
        This.disabled_all[bufnr] = false
        vim.diagnostic.show(nil, 0)
    else
        This.disabled_all[bufnr] = true
        vim.diagnostic.hide(nil, 0)
    end
end

return This
