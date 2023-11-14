local This = {}

function This.set_buf_indent(indent, tab, show)
    vim.bo.expandtab = not tab
    vim.bo.shiftwidth = indent
    vim.bo.softtabstop = indent
    vim.bo.tabstop = indent

    This.set_leadmultispace()

    if show then
        print('Indentation level: ' .. indent .. '; with tabs: ' .. tostring(tab))
    end
end

function This.set_leadmultispace()
    local lms = '·'
    for _ = 2, vim.bo.tabstop do
        lms = lms .. ' '
    end
    vim.opt_local.listchars:append({ leadmultispace = lms })
end

return This
