return {
    'jqno/tranquility.nvim',
    dev = true,

    config = function()
        vim.g.tranquility_overrides = { invert_statusline = true }
        vim.cmd.colorscheme('green-tranquility')

        -- Fix square in the corner between vertical splits
        local hl_statusline = vim.api.nvim_get_hl(0, { name = 'StatusLine', link = true })
        vim.api.nvim_set_hl(0, "StatusLineNC", { bg = hl_statusline.background })
    end
}
