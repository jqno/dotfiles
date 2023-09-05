return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
    },

    config = function()
        require('nvim-treesitter.configs').setup({
            ensure_installed = {
                'bash', 'css', 'html', 'http', 'java', 'javascript', 'json',
                'kotlin', 'lua', 'make', 'markdown', 'nix', 'python', 'regex',
                'ruby', 'rust', 'scala', 'scss', 'sql', 'typescript', 'vim', 'yaml'
            },
            highlight = {
                enable = true
            },
            textobjects = {
                select = { enable = true, keymaps = { ['if'] = '@call.outer' } },
                move = {
                    enable = true,
                    goto_next_start = { [']]'] = '@function.outer' },
                    goto_previous_start = { ['[['] = '@function.outer' }
                },
                lsp_interop = {
                    enable = true,
                    peek_definition_code = {
                        ['<leader>sc'] = '@class.outer',
                        ['<leader>sf'] = '@function.outer'
                    }
                }
            }
        })
    end
}
