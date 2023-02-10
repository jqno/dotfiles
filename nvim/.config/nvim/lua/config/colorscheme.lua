local This = {}

function This.setup()
    vim.cmd.colorscheme('green-tranquility')

    -- Fix square in the corner between vertical splits
    local hl_statusline = vim.api.nvim_get_hl_by_name("StatusLine", true)
    vim.api.nvim_set_hl(0, "StatusLineNC", { bg = hl_statusline.background })
end

return This
