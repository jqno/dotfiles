return {
    'folke/which-key.nvim',
    event = 'UIEnter',

    config = function()
        local wk = require('which-key')
        wk.setup({
            preset = 'modern',
            delay = 1000,
            plugins = {
                marks = false,
                registers = false
            }
        })
        wk.add({
            { '<leader><leader>', icon = '󰠳', desc = 'Navigation' },
            { '<leader>]', icon = '', desc = 'Follow references' },
            { '<leader>b', icon = '', desc = 'Buffer' },
            { '<leader>f', icon = '', desc = 'Find' },
            { '<leader>g', icon = '', desc = 'Go' },
            { '<leader>h', icon = '', desc = 'History' },
            { '<leader>m', icon = '󰡢', desc = 'Make' },
            { '<leader>r', icon = '󰖷', desc = 'Refactor' },
            { '<leader>s', icon = '󰊪', desc = 'Show' },
            { '<leader>t', icon = '', desc = 'Toggle' },
            { '<leader>w', icon = '', desc = 'Window' },
            { '<leader>x', icon = '󱐋', desc = 'Execute' }
        })
    end
}
