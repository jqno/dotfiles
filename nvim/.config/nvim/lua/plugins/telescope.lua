return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.1',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-ui-select.nvim',
    },

    config = function()
        local telescope = require('telescope')
        local actions = require('telescope.actions')

        telescope.setup({
            defaults = {
                vimgrep_arguments = {
                    'rg', '--color=never', '--no-heading', '--with-filename',
                    '--line-number', '--column', '--smart-case', '--hidden'
                },
                mappings = {
                    i = {
                        ['<Space>'] = actions.select_horizontal,
                        ['<C-L>'] = actions.select_vertical,
                        ['<Esc>'] = actions.close
                    }
                },
                layout_strategy = 'vertical',
                prompt_prefix = '❯ ',
                selection_caret = '❯ ',
                path_display = function(_, path)
                    local tail = require('telescope.utils').path_tail(path)
                    return string.format(' %s · %s', tail, path)
                end
            },
            extensions = {
                ['ui-select'] = { require('telescope.themes').get_dropdown() }
            }
        })
        telescope.load_extension('ui-select')
    end
}
