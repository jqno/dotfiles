return {
    'rachartier/tiny-code-action.nvim',
    dependencies = {
        { 'nvim-lua/plenary.nvim' },
        { 'nvim-telescope/telescope.nvim' },
    },
    event = 'LspAttach',
    opts = {}
}
