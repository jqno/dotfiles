local M = {}

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

function M.setup()
  setup_telescope()
end

return M
