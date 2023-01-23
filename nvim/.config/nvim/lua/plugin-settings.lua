local This = {}

local g = vim.g

local function setup_autolist()
    require('autolist').setup()
end

local function setup_autosave()
    require('auto-save').setup({
        enabled = false,
        execution_message = {
            dim = 0.4,
            cleaning_interval = 1000
        }
    })

    -- disable and manually enable after a timeout to make sure the splash screen doesn't disappear
    vim.defer_fn(function() require('auto-save').toggle() end, 100)
end

local function setup_bufdel()
    require('bufdel').setup({
        quit = false
    })
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
    g.floaterm_wintype = 'float'
    g.floaterm_height = 0.95
    g.floaterm_width = 0.95
    g.floaterm_borderchars = '─│─│╭╮╯╰'
end

local function setup_gitconflict()
    require('git-conflict').setup({
        default_mappings = false
    })
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

local function setup_localvimrc()
    g.localvimrc_sandbox = 0
    g.localvimrc_whitelist = { vim.env.HOME .. '/w' }
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
            }
        }
    })
end

local function setup_marks()
    require('marks').setup({
        -- See mappings.lua
        default_mappings = false,
        bookmark_0 = {
            sign = '●'
        }
    })
end

local function setup_nvim_tree()
    require('nvim-tree').setup {
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
end

local function setup_sandwich()
    vim.api.nvim_exec('runtime macros/sandwich/keymap/surround.vim', false)
end

local function setup_siblingswap()
    require('sibling-swap').setup({
        keymaps = {
            ['<leader>r<'] = 'swap_with_left',
            ['<leader>r>'] = 'swap_with_right'
        }
    })
end

local function setup_swapsplit()
    require('swap-split').setup({
        ignore_filetypes = { 'NvimTree', 'qf' }
    })
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

local function setup_treesitter()
    require('nvim-treesitter.configs').setup({
        ensure_installed = {
            'bash', 'css', 'html', 'http', 'java', 'javascript', 'json',
            'kotlin', 'lua', 'make', 'markdown', 'nix', 'python', 'regex',
            'ruby', 'rust', 'scala', 'scss', 'typescript', 'vim', 'yaml'
        },
        highlight = {
            enable = true,
            disable = {
                'lua', -- because it breaks Endwise: see https://github.com/nvim-treesitter/nvim-treesitter/issues/703
                'markdown' -- because the syntax highlighting isn't very good
            }
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
    local function shell_in_floaterm(cmd)
        require('util').floatermsend(cmd)
    end

    g['test#custom_strategies'] = { shell_in_floaterm = shell_in_floaterm }
    g['test#strategy'] = 'shell_in_floaterm'
    g['test#java#maventest#executable'] = 'mvnd'
end

local function setup_wildfire()
    g.wildfire_objects = {
        scala = { 'iw', "i'", "a'", 'i"', 'a"', 'i)', 'i]', 'i}', 'ip' },
        ['xml,xml.pom'] = { 'i}', 'a}', 'i"', 'a"', "i'", "a'", 'it', 'at' }
    }
end

function This.setup()
    setup_autolist()
    setup_autosave()
    setup_bufdel()
    setup_closetag()
    setup_colorizer()
    setup_eunuch()
    setup_floaterm()
    setup_gitconflict()
    setup_gitsigns()
    setup_localvimrc()
    setup_luasnip()
    setup_marks()
    setup_nvim_tree()
    setup_sandwich()
    setup_siblingswap()
    setup_swapsplit()
    setup_telescope()
    setup_treesitter()
    setup_vimtest()
    setup_wildfire()
end

return This
