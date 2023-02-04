return {
    'ThePrimeagen/harpoon',

    dependencies = {
        'nvim-lua/plenary.nvim'
    },
    opts = {
        menu = {
            width = vim.api.nvim_win_get_width(0) - 10,
        }
    }
}
