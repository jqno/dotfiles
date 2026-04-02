local This = {}

function This.expand()
    if vim.treesitter.get_parser(nil, nil, { error = false }) then
        require('vim.treesitter._select').select_parent(vim.v.count1)
    else
        vim.lsp.buf.selection_range(vim.v.count1)
    end
end

function This.contract()
    if vim.treesitter.get_parser(nil, nil, { error = false }) then
        require('vim.treesitter._select').select_child(vim.v.count1)
    else
        vim.lsp.buf.selection_range(-vim.v.count1)
    end
end

return This
