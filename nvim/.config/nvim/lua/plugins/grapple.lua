return {
    'cbochs/grapple.nvim',
    dependencies = {
        { 'nvim-tree/nvim-web-devicons', lazy = true }
    },
    event = 'UIEnter',

    opts = {
        style = 'basename'
    }
}
