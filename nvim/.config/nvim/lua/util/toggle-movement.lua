local This = {}

function This.toggle_movement(firstOp, thenOp)
    -- Inspired by http://ddrscott.github.io/blog/2016/vim-toggle-movement/
    local pos1 = vim.fn.getpos('.')
    vim.cmd('normal! ' .. firstOp)
    if vim.deep_equal(pos1, vim.fn.getpos('.')) then
        vim.cmd('normal! ' .. thenOp)
    end
end

return This
