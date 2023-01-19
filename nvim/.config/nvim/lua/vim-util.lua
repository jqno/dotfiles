local This = {}

function This.augroup(group, events, pattern, fun)
    vim.api.nvim_create_augroup(group, { clear = true })
    vim.api.nvim_create_autocmd(events, {
        group = group,
        pattern = pattern,
        callback = fun
    })
end

return This
