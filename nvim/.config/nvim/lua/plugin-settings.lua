local This = {}

local g = vim.g
local vim_util = require('vim-util')

local function setup_closetag()
    g.closetag_filetypes = 'html,xml'
end

local function setup_colorizer()
    require('colorizer').setup {'css', 'html'}
end

local function setup_floaterm()
    g.floaterm_title = 'Terminal'
    g.floaterm_borderchars = '─│─│╭╮╯╰'
end

local function setup_gitsigns()
    require('gitsigns').setup {
        keymaps = {
            noremap = true,
            buffer = true,

            ['n ]g'] = {
                expr = true,
                [[&diff ? ']c' : '<cmd>lua require("gitsigns").next_hunk()<CR>']]
            },
            ['n [g'] = {
                expr = true,
                [[&diff ? '[c' : '<cmd>lua require("gitsigns").prev_hunk()<CR>']]
            },

            ['n <leader>Gs'] = '<cmd>lua require("gitsigns").stage_hunk()<CR>',
            ['n <leader>Gu'] = '<cmd>lua require("gitsigns").undo_stage_hunk()<CR>',
            ['n <leader>Gr'] = '<cmd>lua require("gitsigns").reset_hunk()<CR>',
            ['n <leader>GR'] = '<cmd>lua require("gitsigns").reset_buffer()<CR>',
            ['n <leader>Gp'] = '<cmd>lua require("gitsigns").preview_hunk()<CR>',
            ['n <leader>Gb'] = '<cmd>lua require("gitsigns").blame_line()<CR>',

            -- Text objects
            ['o ig'] = ':<C-U>lua require("gitsigns").select_hunk()<CR>',
            ['x ig'] = ':<C-U>lua require("gitsigns").select_hunk()<CR>'
        }
    }
end

local function setup_luasnip()
    require('luasnip/loaders/from_vscode').load({
        paths = {vim.fn.stdpath('config') .. '/snippets'}
    })
end

local function setup_nvim_tree()
    require('nvim-tree').setup {
        auto_close = true,
        update_focused_file = {enable = true}
    }

    g.nvim_tree_gitignore = 0
    g.nvim_tree_show_icons = {git = 0, folders = 1}
    g.nvim_tree_quit_on_open = 1
end

local function setup_sandwich()
    vim.api.nvim_exec('runtime macros/sandwich/keymap/surround.vim', false)
end

local function setup_telescope()
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
                    ['<Esc>'] = actions.close
                }
            },
            prompt_prefix = '❯ ',
            selection_caret = '❯ ',
            path_display = function(_, path)
                local tail = require('telescope.utils').path_tail(path)
                return string.format(' %s · %s', tail, path)
            end
        }
    })
    telescope.load_extension('vimwiki')
    telescope.load_extension('fzy_native')
end

local function setup_treesitter()
    require('nvim-treesitter.configs').setup({
        ensure_installed = 'maintained',
        highlight = {
            enable = true,
            disable = {'lua'} -- because it breaks Endwise: see https://github.com/nvim-treesitter/nvim-treesitter/issues/703
        },
        incremental_selection = {
            enable = true,
            keymaps = {init_selection = '<CR>', node_incremental = '<CR>'}
        },
        textobjects = {
            select = {enable = true, keymaps = {['if'] = '@call.outer'}},
            swap = {
                enable = true,
                swap_next = {['<leader>r>'] = '@parameter.inner'},
                swap_previous = {['<leader>r<'] = '@parameter.inner'}
            },
            move = {
                enable = true,
                goto_next_start = {[']]'] = '@function.outer'},
                goto_previous_start = {['[['] = '@function.outer'}
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

local function setup_vimtest()
    g['test#strategy'] = 'floaterm'
    g['test#java#maventest#executable'] = 'mvnd'
end

local function setup_vimwiki()
    g.vimwiki_location = '~/Dropbox/notes'
    g.vimwiki_list = {
        {
            path = g.vimwiki_location,
            syntax = 'markdown',
            ext = '.mkdn',
            links_space_char = '_',
            diary_caption_level = 1
        }
    }
    g.vimwiki_global_ext = 0
    g.vimwiki_markdown_link_ext = 1
    g.vimwiki_map_prefix = '<leader>qx'
    g.vimwiki_key_mappings = {table_mappings = 0}
    g.vimwiki_diary_months = {
        ['1'] = 'Januari',
        ['2'] = 'Februari',
        ['3'] = 'Maart',
        ['4'] = 'April',
        ['5'] = 'Mei',
        ['6'] = 'Juni',
        ['7'] = 'Juli',
        ['8'] = 'Augustus',
        ['9'] = 'September',
        ['10'] = 'Oktober',
        ['11'] = 'November',
        ['12'] = 'December'
    }

    vim_util.augroup('vimwiki', [[
    autocmd BufReadPre,BufEnter,BufNewFile diary.mkdn VimwikiDiaryGenerateLinks
  ]])
end

local function setup_whichkey()
    require('which-key').setup({
        triggers_blacklist = {
            n = {'c', 'v'} -- To avoid conflict with tagalong.vim plugin, which remaps these keys in certain file types
        }
    })
end

local function setup_wildfire()
    g.wildfire_objects = {
        ['scala'] = {'iw', "i'", "a'", 'i"', 'a"', 'i)', 'i]', 'i}', 'ip'},
        ['xml,xml.pom'] = {'i}', 'a}', 'i"', 'a"', "i'", "a'", 'it', 'at'}
    }
end

function This.setup()
    setup_closetag()
    setup_colorizer()
    setup_floaterm()
    setup_gitsigns()
    setup_luasnip()
    setup_nvim_tree()
    setup_sandwich()
    setup_telescope()
    setup_treesitter()
    setup_vimtest()
    setup_vimwiki()
    setup_whichkey()
    setup_wildfire()
end

return This
