return {
    'ibhagwan/fzf-lua',
    dependencies = {
        'nvim-tree/nvim-web-devicons'
    },
    event = 'UIEnter',

    config = function()
        local fzflua = require('fzf-lua')
        local actions = require("fzf-lua").actions
        local modes = require('util.modes')

        fzflua.setup({
            'telescope',
            keymap = {
                fzf = {
                    ['ctrl-a'] = 'toggle-all'
                }
            },
            actions = {
                files = {
                    ['space'] = actions.file_split,
                    ['ctrl-l'] = actions.file_vsplit
                }
            },
            files = {
                formatter = "path.filename_first",
            },
            grep = {
                input_prompt = 'Grep ❯ ',
                hidden = true
            },
            winopts = {
                on_create = function()
                    -- fzf-lua runs in terminal mode. Global mappings for that mode override fzf action hotkeys
                    vim.keymap.set(modes.t, '<C-L>', '<C-L>', { silent = true })
                end
            }
        })
        fzflua.register_ui_select()
    end
}
