local This = {}

local g = vim.g
local mappings = require('mappings').mappings


local function setup_gitsigns()
  require('gitsigns').setup {
    keymaps = {
      noremap = true,
      buffer = true,
      
      ['n ' .. mappings.unimpaired.git_hunk_next] =
          { expr = true, [[&diff ? ']c' : '<cmd>lua require("gitsigns").next_hunk()<CR>']]},
      ['n ' .. mappings.unimpaired.git_hunk_prev] =
          { expr = true, [[&diff ? '[c' : '<cmd>lua require("gitsigns").prev_hunk()<CR>']]},

      ['n ' .. mappings.git.stage_hunk] =
          '<cmd>lua require("gitsigns").stage_hunk()<CR>',
      ['n ' .. mappings.git.undo_stage_hunk] =
          '<cmd>lua require("gitsigns").undo_stage_hunk()<CR>',
      ['n ' .. mappings.git.reset_hunk] =
          '<cmd>lua require("gitsigns").reset_hunk()<CR>',
      ['n ' .. mappings.git.reset_buffer] =
          '<cmd>lua require("gitsigns").reset_buffer()<CR>',
      ['n ' .. mappings.git.preview_hunk] =
          '<cmd>lua require("gitsigns").preview_hunk()<CR>',
      ['n ' .. mappings.git.blame_line] =
          '<cmd>lua require("gitsigns").blame_line()<CR>',

      -- Text objects
      ['o ig'] = ':<C-U>lua require("gitsigns").select_hunk()<CR>',
      ['x ig'] = ':<C-U>lua require("gitsigns").select_hunk()<CR>'
    }
  }
end


local function setup_nvim_tree()
  g.nvim_tree_auto_close = 1
  g.nvim_tree_follow = 1
  g.nvim_tree_gitignore = 1
  g.nvim_tree_show_icons = { git = 0, folders = 1 }
  g.nvim_tree_quit_on_open = 1
  g.nvim_tree_icons = {
    folder = {
      default = '>',
      open = '∨',
      empty = '>',
      empty_open = '∨',
      symlink = '>',
      symlink_open = '∨'
    }
  }
end


local function setup_sandwich()
  vim.api.nvim_exec('runtime macros/sandwich/keymap/surround.vim', false)
end


local function setup_telescope()
  local telescope = require('telescope') 
  local actions = require('telescope.actions')

  telescope.setup({
    defaults = {
      mappings = {
        i = {
          [mappings.specific_modes.telescope_i_split] = actions.select_horizontal,
          [mappings.specific_modes.telescope_i_close] = actions.close
        },
      },
      prompt_prefix = '❯ ',
      selection_caret = '❯ '
    }
  })
  telescope.load_extension('fzy_native')
end


local function setup_treesitter()
  require('nvim-treesitter.configs').setup({
    ensure_installed = 'maintained',
    highlight = { 
      enable = true,
      disable = { 'lua' } -- because it breaks Endwise: see https://github.com/nvim-treesitter/nvim-treesitter/issues/703
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = mappings.various.wildfire,
        node_incremental = mappings.various.wildfire
      }
    },
    textobjects = {
      select = {
        enable = true,
        keymaps = { ['if'] = '@call.outer' }
      },
      swap = {
        enable = true,
        swap_next = {
          [mappings.refactor.swap_next] = '@parameter.inner'
        },
        swap_previous = {
          [mappings.refactor.swap_prev] = '@parameter.inner'
        }
      },
      move = {
        enable = true,
        goto_next_start = {
          [mappings.unimpaired.function_next] = '@function.outer'
        },
        goto_previous_start = {
          [mappings.unimpaired.function_prev] = '@function.outer'
        }
      },
      lsp_interop = {
        enable = true,
        peek_definition_code = {
          [mappings.show.peek_class] = '@class.outer',
          [mappings.show.peek_function] = '@function.outer'
        }
      }
    }
  })
end


local function setup_ultisnips()
  -- Mapping F19 instead of NOP because the latter isn't recognised properly
  vim.g.UltiSnipsExpandTrigger = '<F19>'
  vim.g.UltiSnipsJumpForwardTrigger = '<F19>'
  vim.g.UltiSnipsJumpBackwardTrigger = '<F19>'
end


local function setup_vimwiki()
  g.vimwiki_location = '~/Dropbox/notes'
  g.vimwiki_list = {
    { path = g.vimwiki_location, syntax = 'markdown', ext = '.mkdn', links_space_char = '_' }
  }
  g.vimwiki_global_ext = 0
  g.vimwiki_markdown_link_ext = 1
  g.vimwiki_key_mappings = { table_mappings = 0}
  g.vimwiki_diary_months =
    { ['1'] = 'Januari', ['2'] = 'Februari', ['3'] = 'Maart', ['4'] = 'April',
      ['5'] = 'Mei', ['6'] = 'Juni', ['7'] = 'Juli', ['8'] = 'Augustus',
      ['9'] = 'September', ['10'] = 'Oktober', ['11'] = 'November', ['12'] = 'December' }
end


local function setup_wildfire()
  g.wildfire_objects = {
    ['scala'] = {'iw', "i'", "a'", 'i"', 'a"', 'i)', 'i]', 'i}', 'ip'}
  }
end


function This.setup()
  setup_gitsigns()
  setup_nvim_tree()
  setup_sandwich()
  setup_telescope()
  setup_treesitter()
  setup_ultisnips()
  setup_vimwiki()
  setup_wildfire()
end

return This
