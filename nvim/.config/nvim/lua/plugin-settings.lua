local This = {}

local g = vim.g
local vim_util = require('vim-util')

local function setup_bullets()
    g.bullets_outline_levels = { 'std-' }
    g.bullets_enabled_file_types = { 'markdown', 'text', 'gitcommit', 'asciidoc' }
end

local function setup_closetag()
    g.closetag_filetypes = 'html,xml'
end

local function setup_colorizer()
    require('colorizer').setup { 'css', 'html' }
end

local function setup_eunuch()
    g.eunuch_no_maps = true
end

local function setup_floaterm()
    g.floaterm_title = 'Terminal'
    g.floaterm_borderchars = '─│─│╭╮╯╰'
end

local function setup_gitsigns()
    require('gitsigns').setup {
        preview_config = {
            border = 'rounded'
        },
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

local function setup_lsp_format()
    require('lsp-format').setup()
end

local function setup_luasnip()
    -- Adding snippets for a new filetype? Don't forget to update `snippets/package.json`!
    require('luasnip/loaders/from_vscode').lazy_load({
        paths = { vim.fn.stdpath('config') .. '/snippets' }
    })
    local types = require('luasnip.util.types')
    require('luasnip').config.setup({
        region_check_events = 'CursorHold',
        ext_opts = {
            [types.choiceNode] = {
                active = { virt_text = { { '●', 'GitSignsChange' } } }
            },
            [types.insertNode] = {
                active = { virt_text = { { '●', 'GitSignsAdd' } } }
            }
        }
    })
end

local function setup_nvim_tree()
    require('nvim-tree').setup { update_focused_file = { enable = true } }

    g.nvim_tree_gitignore = 0
    g.nvim_tree_group_empty = 1
    g.nvim_tree_show_icons = { git = 0, folders = 1 }
    g.nvim_tree_quit_on_open = 1

    vim.api.nvim_create_augroup('close_tree_if_last_window', { clear = true })
    vim.api.nvim_create_autocmd('BufEnter', {
        group = 'close_tree_if_last_window',
        pattern = '*',
        nested = true,
        callback = function() vim.cmd("if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif") end
    })
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
    telescope.load_extension('fzy_native')
end

local function setup_treesitter()
    require('nvim-treesitter.configs').setup({
        ensure_installed = {
            'bash', 'css', 'html', 'http', 'java', 'javascript', 'json',
            'kotlin', 'lua', 'make', 'markdown', 'nix', 'python', 'regex',
            'ruby', 'rust', 'scala', 'scss', 'typescript', 'vim', 'yaml'
        },
        highlight = {
            enable = true,
            disable = { 'lua' } -- because it breaks Endwise: see https://github.com/nvim-treesitter/nvim-treesitter/issues/703
        },
        incremental_selection = {
            enable = true,
            keymaps = { init_selection = '<CR>', node_incremental = '<CR>' }
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

local function setup_vimtest()
    g['test#strategy'] = 'floaterm'
    g['test#java#maventest#executable'] = 'mvnd'
end

local function setup_whichkey()
    require('which-key').setup({
        triggers_blacklist = {
            n = { 'c', 'v' } -- To avoid conflict with tagalong.vim plugin, which remaps these keys in certain file types
        }
    })
end

local function setup_wikivim()
    g.wiki_root = '~/Dropbox/notes'
    g.wiki_filetypes = { 'mkdn' }
    g.wiki_link_extension = '.mkdn'
    g.wiki_link_target_type = 'md'
    g.wiki_mappings_use_defaults = 'none'

    -- Enable mappings manually to avoid conflict with Wildfire (which also uses <CR>)
    vim_util.augroup(
        'enable_wikivim_mappings',
        { 'BufRead', 'BufNewFile' },
        vim.env.HOME .. "/Dropbox/notes/**",
        require('mappings').setup_wikivim)
end

local function setup_wildfire()
    g.wildfire_objects = {
        scala = { 'iw', "i'", "a'", 'i"', 'a"', 'i)', 'i]', 'i}', 'ip' },
        ['xml,xml.pom'] = { 'i}', 'a}', 'i"', 'a"', "i'", "a'", 'it', 'at' }
    }
end

function This.setup()
    setup_bullets()
    setup_closetag()
    setup_colorizer()
    setup_eunuch()
    setup_floaterm()
    setup_gitsigns()
    setup_lsp_format()
    setup_luasnip()
    setup_nvim_tree()
    setup_sandwich()
    setup_telescope()
    setup_treesitter()
    setup_vimtest()
    setup_whichkey()
    setup_wikivim()
    setup_wildfire()
end

return This
