return {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
        'kyazdani42/nvim-web-devicons'
    },
    cmd = { 'NvimTreeFindFileToggle', 'NvimTreeClose' },

    opts = {
        view = {
            adaptive_size = true
        },
        update_focused_file = {
            enable = true
        },
        renderer = {
            group_empty = true,
            icons = {
                show = {
                    git = false
                }
            }
        },
        actions = {
            open_file = {
                quit_on_open = true
            }
        },
        git = {
            ignore = false
        }
    }
}
