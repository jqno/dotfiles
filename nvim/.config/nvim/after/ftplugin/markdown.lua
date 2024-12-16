local map = vim.keymap.set
local modes = require('util.modes')

vim.opt_local.wrap = true

require('util.autolist').setup()

local id = nil
id = vim.api.nvim_create_autocmd('InsertLeave', {
    group = vim.api.nvim_create_augroup('disable_markdown_render', { clear = true }),
    buffer = 0,
    callback = function()
        vim.cmd.RenderMarkdown('disable')
        if id ~= nil then
            vim.api.nvim_del_autocmd(id)
        end
    end
})

map(modes.n, '<leader>tr', '<cmd>RenderMarkdown toggle<CR>', { desc = 'toggle Markdown rendering' })
