return {
    'zbirenbaum/copilot.lua',
    event = 'InsertEnter',
    cmd = 'Copilot',

    opts = {
        panel = {
            keymap = {
                jump_prev = '<C-K>',
                jump_next = '<C-J>',
                accept = '<CR>',
                refresh = '<C-R>',
                open = '<C-A>'
            },
            layout = {
                position = 'right'
            }
        },
        suggestion = {
            enabled = true,
            auto_trigger = false,
            keymap = false -- We use custom mappings
        }
    }
}
