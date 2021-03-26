-- HELPERS --
local modes = { i = 'i', n = 'n' }

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- LEADER --
vim.g.mapleader = ' '

-- COMPLETION --
map(modes.i, '<Tab>', 'v:lua.tab_complete()', { expr = true })
map(modes.i, '<S-Tab>', 'v:lua.s_tab_complete()', { expr = true })
map(modes.i, '<CR>', 'compe#confirm("<CR>")', { expr = true })

-- FINDING --
map(modes.n, '<leader>ff', '<cmd>Telescope find_files<CR>')
map(modes.n, '<leader>fg', '<cmd>Telescope live_grep<CR>')
