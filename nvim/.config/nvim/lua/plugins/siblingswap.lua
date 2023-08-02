return {
    'Wansmer/sibling-swap.nvim',
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
    },

    opts = {
        use_default_keymaps = false,
        keymaps = {
            ['<leader>r<'] = 'swap_with_left',
            ['<leader>r>'] = 'swap_with_right'
        }
    }
}
