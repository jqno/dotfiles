return {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
        'zbirenbaum/copilot.lua',
        'nvim-lua/plenary.nvim',
    },
    event = 'UIEnter',

    opts = {
        mappings = {
            submit_prompt = {
                normal = '<CR>',
                insert = '<C-CR>'
            },
            accept_diff = {
                normal = '<C-L>',
                insert = '<C-L>'
            },
            reset = {
                normal = '<C-Q>',
                insert = '<C-Q>'
            }
        }
    }
}
