local This = {}

function This.create(group, events, pattern, fun)
    local grp = vim.api.nvim_create_augroup(group, { clear = true })
    vim.api.nvim_create_autocmd(events, {
        group = grp,
        pattern = pattern,
        callback = fun
    })
end

return This
