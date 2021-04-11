local M = {}

-- HELPERS --
local modes = { i = 'i', n = 'n', v = 'v', c = 'c', s = 's' }

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end


-- COMMANDS --
local function define_commands()
  -- prevent silly shift-pressing mistakes
  vim.api.nvim_exec([[
    command! -bang -nargs=* -complete=file E e<bang> <args>
    command! -bang -nargs=* -complete=file W w<bang> <args>
    command! -bang -nargs=* -complete=file Wq wq<bang> <args>
    command! -bang -nargs=* -complete=file WQ wq<bang> <args>
    command! -bang Wa wa<bang>
    command! -bang WA wa<bang>
    command! -bang Q q<bang>
    command! -bang QA qa<bang>
    command! -bang Qa qa<bang>
  ]], false)
end


-- MAPPINGS --
local function define_mappings()
  -- LEADER --
  vim.g.mapleader = ' '


  -- VARIOUS --
  map(modes.n, 'Y', '"+y')
  map(modes.v, 'Y', '"+y')
  map(modes.n, '\\\\', '<Plug>CommentaryLine', { noremap = false })
  map(modes.v, '\\', '<Plug>Commentary', { noremap = false })
  map(modes.s, '<C-L>', '<Esc>:call UltiSnips#JumpForwards()<CR>', { nowait = true, silent = true })


  -- NAVIGATION --
  map(modes.n, 'j', [[v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj']], { expr = true })
  map(modes.n, 'k', [[v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk']], { expr = true })
  map(modes.v, 'j', [[v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj']], { expr = true })
  map(modes.v, 'k', [[v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk']], { expr = true })


  -- COMPLETION --
  _G.compe = require('completion')
  map(modes.i, '<Tab>', 'v:lua.compe.tab_complete()', { expr = true })
  map(modes.i, '<S-Tab>', 'v:lua.compe.s_tab_complete()', { expr = true })
  map(modes.i, '<CR>', 'v:lua.compe.cr_complete()', { expr = true })


  -- FINDING --
  map(modes.n, '<leader>fb', '<cmd>Telescope buffers show_all_buffers=true<CR>')
  map(modes.n, '<leader>ff', '<cmd>Telescope find_files<CR>')
  map(modes.n, '<leader>fi', '<cmd>Telescope treesitter<CR>')
  map(modes.n, '<leader>fn', '<cmd>NvimTreeToggle<CR>')
  map(modes.n, '<leader>fN', '<cmd>NvimTreeFindFile<CR>')
  map(modes.n, '<leader>fg', '<cmd>lua require("telescope.builtin").grep_string({ search = vim.fn.input("Grep ❯ ") })<CR>')
  map(modes.n, '<leader>f*', '<cmd>lua require("telescope.builtin").grep_string({ search = vim.fn.expand("<cword>") })<CR>')


  -- COMMAND-LINE MODE --
  -- Expand %% to the directory of the currently open file
  map(modes.c, '%%', [[<C-R>=expand('%:h') . '/'<CR>]])
end


-- TREESITTER MAPPINGS --
function M.treesitter()
  return {
    incremental_selection = '<CR>',
    goto_next_function = ']]',
    goto_prev_function = '[[',
    refactor_swap_next = '<leader>r>',
    refactor_swap_prev = '<leader>r<',
    show_peek_class = '<leader>sc',
    show_peek_function = '<leader>sf',
    telescope_i_split = '<space>',
    telescope_i_close = '<esc>'
  }
end


-- LSP MAPPINGS --
function M.setup_lsp(client, bufnr)
  local function buf_map(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local opts = { noremap = true, silent = true }


  -- VARIOUS --
  buf_map(modes.n, 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_map(modes.i, '<C-Space>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)


  -- FINDING --
  buf_map(modes.n, '<leader>fs', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', opts)
  buf_map(modes.n, '<leader>fr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)


  -- GOING PLACES  --
  buf_map(modes.n, '<leader>g]', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_map(modes.n, '<leader>gd', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_map(modes.n, '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_map(modes.n, '<leader>dt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_map(modes.n, '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_map(modes.n, ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)


  -- MAKE-ING --
  if client.resolved_capabilities.document_formatting then
    buf_map(modes.n, '<space>mf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_map(modes.n, '<space>mf', '<cmd>lua vim.lsp.buf.range_formatting()<CR>', opts)
  end


  -- REFACTORING --
  buf_map('n', '<leader>rr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)


  -- SHOWING THINGS --
  buf_map(modes.n, '<leader>ss', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
end


function M.setup()
  define_commands()
  define_mappings()
end

return M
