local M = {}

local g = vim.g


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
          ['<space>'] = actions.select_horizontal,
          ['<esc>'] = actions.close
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
    highlight = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<CR>',
        node_incremental = '<CR>'
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
          ['<leader>r>'] = '@parameter.inner'
        },
        swap_previous = {
          ['<leader>r<'] = '@parameter.inner'
        }
      },
      move = {
        enable = true,
        goto_next_start = {
          [']]'] = '@function.outer'
        },
        goto_previous_start = {
          ['[['] = '@function.outer'
        }
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


local function setup_ultisnips()
  -- Mapping F19 instead of NOP because the latter isn't recognised properly
  vim.g.UltiSnipsExpandTrigger = '<F19>'
  vim.g.UltiSnipsJumpForwardTrigger = '<F19>'
  vim.g.UltiSnipsJumpBackwardTrigger = '<F19>'
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
  setup_wildfire()
end

return M
