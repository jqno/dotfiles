local M = {}

-- HELPERS --
local modes = { i = 'i', n = 'n' }

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function M.setup()
  -- LEADER --
  vim.g.mapleader = ' '

  -- COMPLETION --
  local c = require('completion')
  _G.tab_complete = c.tab_complete
  _G.s_tab_complete = c.s_tab_complete
  map(modes.i, '<Tab>', 'v:lua.tab_complete()', { expr = true })
  map(modes.i, '<S-Tab>', 'v:lua_s_tab_complete()', { expr = true })
  map(modes.i, '<CR>', 'compe#confirm("<CR>")', { expr = true })

  -- FINDING --
  map(modes.n, '<leader>ff', '<cmd>Telescope find_files<CR>')
  map(modes.n, '<leader>fg', '<cmd>Telescope live_grep<CR>')
end

-- LSP --
function M.setup_lsp(client, bufnr)
  local function buf_map(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local opts = { noremap = true, silent = true }

  buf_map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)

  buf_map('n', '<leader>fs', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', opts)
  buf_map('n', '<leader>fr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

  buf_map('n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_map('n', '<leader>gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_map('n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_map('n', '<leader>dt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_map('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_map('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)

  buf_map('n', '<leader>rr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)

  if client.resolved_capabilities.document_formatting then
    buf_map("n", "<space>mf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_map("n", "<space>mf", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end
end


return M
