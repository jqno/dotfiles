local This = {}

function This.format(params)
    local p = params or {}
    local async = p.async or false
    local bufnr = p.bufnr or vim.fn.bufnr()

    if vim.g.do_autoformat or vim.b[bufnr].do_autoformat then
        require('conform').format({ bufnr = bufnr, async = async, lsp_fallback = true })
    end
end

return This
