local modes = require('util.modes')
local map = vim.keymap.set

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

            map(modes.n, '<CR>', api.node.open.edit, opts('Open'))
            map(modes.n, 'J', api.node.open.horizontal, opts('Open in horitzontal split'))
            map(modes.n, 'L', api.node.open.vertical, opts('Open in vertical split'))
            map(modes.n, 'K', api.node.show_info_popup, opts('Info'))
            map(modes.n, 'R', api.tree.reload, opts('Refresh'))
            map(modes.n, 'a', api.fs.create, opts('Create'))
            map(modes.n, 'd', api.fs.remove, opts('Delete'))
            map(modes.n, 'g?', api.tree.toggle_help, opts('Help'))
            map(modes.n, 'p', api.fs.paste, opts('Paste'))
            map(modes.n, 'r', api.fs.rename, opts('Rename'))
            map(modes.n, 'x', api.fs.cut, opts('Cut'))
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
                git_placement = 'after'
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
