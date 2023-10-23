local function add_file()
    require('harpoon.mark').add_file()
    print('File added to Harpoon list')
end

return {
    'ThePrimeagen/harpoon',
    lazy = true,

    dependencies = {
        'nvim-lua/plenary.nvim'
    },
    opts = {
        menu = {
            width = vim.api.nvim_win_get_width(0) - 10,
        }
    },

    add_file = add_file
}
