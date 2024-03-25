local This = {}

function This.set_buf_indent(indent, tab, show)
    vim.opt_local.expandtab = not tab
    vim.opt_local.shiftwidth = indent
    vim.opt_local.softtabstop = indent
    vim.opt_local.tabstop = indent

    This.set_leadmultispace()

    if show then
        print('Indentation level: ' .. indent .. '; with tabs: ' .. tostring(tab))
    end
end

function This.set_leadmultispace()
    local lms = '·'
    for _ = 2, vim.opt_local.tabstop:get() do
        lms = lms .. ' '
    end
    vim.opt_local.listchars:append({ leadmultispace = lms })
end

return This
