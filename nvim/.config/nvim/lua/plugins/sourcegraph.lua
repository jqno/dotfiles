local function load_cody()
    vim.cmd('Lazy load sg.nvim')

    local modes = require('util.modes')
    vim.keymap.set(modes.n, '<leader>aa', '<cmd>CodyToggle<CR>', { desc = 'toggle Cody Chat' })
    vim.keymap.set(modes.v, '<leader>aa', ':CodyAsk ', { desc = 'ask Cody a question about selection' })
    vim.keymap.set(modes.n, '<leader>an', '<cmd>CodyChat!<CR>', { desc = 'start new Cody Chat conversation' })
    vim.keymap.del(modes.n, '<leader>a<CR>')

    print('Cody activated')
    vim.g.cody_loaded = true
end

return {
    'sourcegraph/sg.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = 'VimLeave', -- Never load automatically

    opts = {},

    load_cody = load_cody
}
