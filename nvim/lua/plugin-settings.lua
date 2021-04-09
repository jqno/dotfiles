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


local function setup_wildfire()
  -- textobject 'if' from jqno/jqno-textobj-functioncall.vim
  g.wildfire_objects = {
    ['*'] = {'iw', "i'", "a'", 'i"', 'a"', 'i)', 'i]', 'i}', 'if', 'ip'},
    ['html,xml,xml.pom'] = {'i}', 'a}', 'it', 'at'}
  }
end


function M.setup()
  setup_nvim_tree()
  setup_telescope()
  setup_wildfire()
end

return M
