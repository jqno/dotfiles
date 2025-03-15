return {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
        'zbirenbaum/copilot.lua',
        'nvim-lua/plenary.nvim',
    },
    event = 'UIEnter',

    opts = {
        mappings = {
            accept_diff = {
                normal = '<C-L>',
                insert = '<C-L>'
            }
        }
    }
}
