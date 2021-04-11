local M = {}

local g = vim.g
local mappings = require('mappings').treesitter()


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


local function setup_telescope()
  local telescope = require('telescope') 
  local actions = require('telescope.actions')

  telescope.setup({
    defaults = {
      mappings = {
        i = {
          [mappings.telescope_i_split] = actions.select_horizontal,
          [mappings.telescope_i_close] = actions.close
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
        init_selection = mappings.incremental_selection,
        node_incremental = mappings.incremental_selection
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
          [mappings.refactor_swap_next] = '@parameter.inner'
        },
        swap_previous = {
          [mappings.refactor_swap_prev] = '@parameter.inner'
        }
      },
      move = {
        enable = true,
        goto_next_start = {
          [mappings.goto_next_function] = '@function.outer'
        },
        goto_previous_start = {
          [mappings.goto_prev_function] = '@function.outer'
        }
      },
      lsp_interop = {
        enable = true,
        peek_definition_code = {
          [mappings.show_peek_class] = '@class.outer',
          [mappings.show_peek_function] = '@function.outer'
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
end


local function setup_wildfire()
  g.wildfire_objects = {
    ['scala'] = {'iw', "i'", "a'", 'i"', 'a"', 'i)', 'i]', 'i}', 'ip'}
  }
end


function M.setup()
  setup_nvim_tree()
  setup_telescope()
  setup_treesitter()
  setup_ultisnips()
  setup_vimwiki()
  setup_wildfire()
end

return M
