return {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
        'nvim-tree/nvim-web-devicons'
    },
    cmd = { 'NvimTreeFindFileToggle', 'NvimTreeClose' },

    opts = {
        on_attach = function(bufnr)
            local api = require('nvim-tree.api')

            local function opts(desc)
                return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
            end

            vim.keymap.set('n', '<CR>',  api.node.open.edit,       opts('Open'))
            vim.keymap.set('n', 'J',     api.node.open.horizontal, opts('Open in horitzontal split'))
            vim.keymap.set('n', 'L',     api.node.open.vertical,   opts('Open in vertical split'))
            vim.keymap.set('n', 'K',     api.node.show_info_popup, opts('Info'))
            vim.keymap.set('n', 'R',     api.tree.reload,          opts('Refresh'))
            vim.keymap.set('n', 'a',     api.fs.create,            opts('Create'))
            vim.keymap.set('n', 'd',     api.fs.remove,            opts('Delete'))
            vim.keymap.set('n', 'g?',    api.tree.toggle_help,     opts('Help'))
            vim.keymap.set('n', 'p',     api.fs.paste,             opts('Paste'))
            vim.keymap.set('n', 'r',     api.fs.rename,            opts('Rename'))
            vim.keymap.set('n', 'x',     api.fs.cut,               opts('Cut'))
        end,
        view = {
            adaptive_size = true,
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
