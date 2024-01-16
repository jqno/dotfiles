local This = {}

function This.is_editable(bufnr)
    return vim.api.nvim_buf_get_option(bufnr, 'modifiable')
        and not vim.api.nvim_buf_get_option(bufnr, 'readonly')
end

return This
