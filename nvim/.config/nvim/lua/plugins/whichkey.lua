return {
    'folke/which-key.nvim',
    event = 'UIEnter',

    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 1000
    end,
    config = function()
        local wk = require('which-key')
        wk.setup({
            window = {
                border = 'single'
            },
            triggers_blacklist = {
                n = { 'c', 'v' } -- To avoid conflict with tagalong.vim plugin, which remaps these keys in certain file types
            }
        })
        wk.register({
            ['<leader>'] = {
                [']'] = 'Follow references',
                ['<leader>'] = 'Navigation',
                a = 'AI',
                b = 'Buffer',
                d = 'Debug',
                f = 'Find',
                g = 'Go',
                h = 'History',
                m = 'Make',
                r = 'Refactor',
                s = 'Show',
                t = 'Toggle',
                w = 'Window',
                x = 'Execute'
            }
        })
    end
}
