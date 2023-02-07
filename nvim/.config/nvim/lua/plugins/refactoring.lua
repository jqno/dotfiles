return {
    'ThePrimeagen/refactoring.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-treesitter/nvim-treesitter'
    },
    lazy = true,

    opts = {
        prompt_func_return_type = {
            java = true
        },
        prompt_func_param_type = {
            java = true
        }
    }
}
