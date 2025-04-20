local This = {}

local ASPECT_THRESHOLD = 1.8

This.PORTRAIT = 1
This.LANDSCAPE = -1

function This.get_orientation()
    local columns = vim.api.nvim_get_option_value('columns', {})
    local lines = vim.api.nvim_get_option_value('lines', {})
    local aspect_ratio = columns / lines

    if aspect_ratio < ASPECT_THRESHOLD then
        return This.PORTRAIT
    else
        return This.LANDSCAPE
    end
end

function This.get_layout()
    if This.get_orientation() == This.PORTRAIT then
        return 'horizontal'
    else
        return 'vertical'
    end
end

function This.get_split()
    if This.get_orientation() == This.PORTRAIT then
        return 'split'
    else
        return 'vsplit'
    end
end

return This
