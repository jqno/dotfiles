return {
    "ibhagwan/fzf-lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons"
    },
    event = 'UIEnter',

    config = function()
        local fzflua = require('fzf-lua')
        fzflua.setup({
            'telescope',
            keymap = {
                fzf = {
                    ['ctrl-a'] = 'toggle-all'
                }
            },
            files = {
                formatter = "path.filename_first",
            },
            grep = {
                input_prompt = 'Grep ❯ ',
                hidden = true
            }
        })
        fzflua.register_ui_select()
    end
}
