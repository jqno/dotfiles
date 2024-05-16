local This = {}

-- Inspired by and adapted from http://stackoverflow.com/a/36653470/127863

local actions = {
    h = 'vertical resize -',
    j = 'resize +',
    k = 'resize -',
    l = 'vertical resize +'
}

local opposites = {
    h = 'l',
    j = 'k',
    k = 'j',
    l = 'h'
}

local function is_edge_window_selected(direction)
    local curwindow = vim.fn.winnr()
    vim.cmd('wincmd ' .. direction)
    local result = curwindow == vim.fn.winnr()
    if not result then vim.cmd(curwindow .. 'wincmd w') end
    return result
end

function This.resize_split(direction, amount)
    local action = actions[direction]
    local opposite = opposites[direction]
    local curwindow = vim.fn.winnr()

    if (direction == 'j' or direction == 'l') and is_edge_window_selected(direction) then
        vim.cmd('wincmd ' .. opposite)
    elseif (direction == 'h' or direction == 'k') and is_edge_window_selected(opposite) then
        vim.cmd('wincmd ' .. direction)
    else
        vim.cmd(action .. amount)
        print('> ' .. action .. amount)
        return
    end

    vim.cmd(action .. amount)
    print('> ' .. action .. amount)
    vim.cmd(curwindow .. 'wincmd w')
end

return This
