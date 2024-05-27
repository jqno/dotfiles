return {
    'Bekaboo/dropbar.nvim',
    event = 'UIEnter',

    config = function()
        vim.opt.mousemoveevent = true
        vim.api.nvim_set_hl(0, 'WinBar', { link = 'Normal' })
        vim.api.nvim_set_hl(0, 'WinBarNC', { link = 'Normal' })
    end,
}
