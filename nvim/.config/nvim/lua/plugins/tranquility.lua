return {
    'jqno/tranquility.nvim',
    dev = true,

    config = function()
        vim.g.tranquility_overrides = { invert_statusline = true }
    end
}
