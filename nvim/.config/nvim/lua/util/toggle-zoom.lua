local This = {}

vim.t.toggle_zoom = false

function This.toggle_zoom()
    if vim.t.toggle_zoom then
        vim.cmd.wincmd('=')
    else
        vim.cmd.wincmd('_')
        vim.cmd.wincmd('|')
    end
    vim.t.toggle_zoom = not vim.t.toggle_zoom
end

function This.is_zoomed()
    return vim.t.toggle_zoom
end

return This
