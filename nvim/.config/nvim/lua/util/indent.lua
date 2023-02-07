local This = {}

function This.set_buf_indent(indent, tab, show)
    vim.bo.expandtab = not tab
    vim.bo.shiftwidth = indent
    vim.bo.softtabstop = indent
    vim.bo.tabstop = indent
    if show then
        print('Indentation level: ' .. indent .. '; with tabs: ' .. tostring(tab))
    end
end

return This
