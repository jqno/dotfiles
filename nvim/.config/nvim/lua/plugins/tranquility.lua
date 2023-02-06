return {
    'jqno/tranquility.nvim',
    lazy = false,
    dev = true,

    config = function()
        vim.g.tranquility_overrides = { invert_statusline = true }
        vim.cmd.colorscheme('green-tranquility')
    end
}
