return {
    'Wansmer/sibling-swap.nvim',
    lazy = true,
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
    },

    opts = {
        use_default_keymaps = false,
        highlight_node_at_cursor = true,
    }
}
