local This = {}

function This.is_editable(bufnr)
    return vim.api.nvim_get_option_value('modifiable', { buf = bufnr })
        and not vim.api.nvim_get_option_value('readonly', { buf = bufnr })
end

return This
