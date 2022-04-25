local This = {}

function This.map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend('force', options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function This.buf_map(bufnr, mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend('force', options, opts)
    end
    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, options)
end

function This.augroup(group, events, pattern, fun)
    vim.api.nvim_create_augroup(group, { clear = true })
    vim.api.nvim_create_autocmd(events, {
        group = group,
        pattern = pattern,
        callback = fun
    })
end

return This
