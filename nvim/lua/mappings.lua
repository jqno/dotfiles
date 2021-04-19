local M = {}
local map = require('util').map

M.modes = { i = 'i', n = 'n', v = 'v', c = 'c', s = 's' }

M.mappings = {
  various = {
    close_everything    = '<leader><Esc>',
    comment             = '\\',
    comment_line        = '\\\\',
    scroll_popup_down   = '<leader><C-D>',
    scroll_popup_up     = '<leader><C-U>',
    signature_help      = '<C-Space>',
    vimwiki             = '<F12>',
    wildfire            = '<CR>',
    yank_to_clipboard   = 'Y'
  },
  specific_modes = {
    expand_current_path = '%%',
    telescope_i_close   = '<Esc>',
    telescope_i_split   = '<Space>',
    ulti_jump           = '<C-L>'
  },
  unimpaired = {
    diagnostic_next     = ']d',
    diagnostic_prev     = '[d',
    function_next       = ']]',
    function_prev       = '[['
  },
  debug = {
    breakpoint          = '<leader>db',
    continue            = '<leader>dc',
    run                 = '<leader>dr',
    run_last            = '<leader>dl',
    step_into           = '<leader>di',
    step_over           = '<leader>do',
    step_out            = '<leader>dx',
    test                = '<leader>dt',
    test_nearest        = '<leader>dn',
    toggle_repl         = '<leader>d<Space>'
  },
  execute = {
    linkify             = '<leader>xl'
  },
  find = {
    buffers             = '<leader>fb',
    current_word        = '<leader>f*',
    files               = '<leader>ff',
    grep                = '<leader>fg',
    identifier          = '<leader>fi',
    references          = '<leader>fr',
    symbols             = '<leader>fs',
    tree                = '<leader>fn',
    tree_follow         = '<leader>fN',
    wiki                = '<leader>f<F12>'
  },
  go = {
    definition          = '<leader>g]',
    declaration         = '<leader>gd',
    implementation      = '<leader>gi',
    type_definition     = '<leader>gt',
  },
  make = {
    format              = '<leader>mf',
    rebuild             = '<leader>mr'
  },
  refactor = {
    code_action         = '<leader>r<CR>',
    extract_method      = '<leader>rm',
    extract_variable    = '<leader>rv',
    menu                = '<leader>r<Space>',
    organize_imports    = '<leader>ro',
    rename              = '<leader>rr',
    swap_next           = '<leader>r>',
    swap_prev           = '<leader>r<'
  },
  show = {
    debug_value         = '<leader>sv',
    diagnostic          = '<leader>sd',
    diagnostic_line     = '<leader>sD',
    peek_class          = '<leader>sc',
    peek_function       = '<leader>sf',
    signature_help      = '<leader>ss'
  }
}


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


function M.close_everything()
  vim.api.nvim_command('pclose')
  vim.api.nvim_command('cclose')
  vim.api.nvim_command('NvimTreeClose')
  require('dap').repl.close()
end


-- MAPPINGS --
local function define_mappings()
  -- LEADER --
  vim.g.mapleader = ' '


  -- VARIOUS --
  local various = M.mappings.various
  map(M.modes.n, various.yank_to_clipboard,
      '"+y')
  map(M.modes.v, various.yank_to_clipboard,
      '"+y')
  map(M.modes.n, various.comment_line,
      '<Plug>CommentaryLine', { noremap = false })
  map(M.modes.v, various.comment,
      '<Plug>Commentary', { noremap = false })
  map(M.modes.n, various.vimwiki,
      '<cmd>VimwikiIndex<CR>')
  map(M.modes.n, various.close_everything,
      '<cmd>lua require("mappings").close_everything()<CR>', { silent = true })


  -- NAVIGATION --
  map(M.modes.n, 'j',
      [[v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj']], { expr = true })
  map(M.modes.n, 'k',
      [[v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk']], { expr = true })
  map(M.modes.v, 'j',
      [[v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj']], { expr = true })
  map(M.modes.v, 'k',
      [[v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk']], { expr = true })


  -- COMPLETION --
  _G.compe = require('completion')
  map(M.modes.i, '<Tab>',
      'v:lua.compe.tab_complete()', { expr = true })
  map(M.modes.i, '<S-Tab>',
      'v:lua.compe.s_tab_complete()', { expr = true })
  map(M.modes.i, '<CR>',
      'v:lua.compe.cr_complete()', { expr = true })


  -- FINDING --
  local find = M.mappings.find
  map(M.modes.n, find.buffers,
      '<cmd>Telescope buffers show_all_buffers=true<CR>')
  map(M.modes.n, find.files,
      '<cmd>Telescope find_files<CR>')
  map(M.modes.n, find.identifier,
      '<cmd>Telescope treesitter<CR>')
  map(M.modes.n, find.tree,
      '<cmd>NvimTreeToggle<CR>')
  map(M.modes.n, find.tree_follow,
      '<cmd>NvimTreeFindFile<CR>')
  map(M.modes.n, find.grep,
      '<cmd>lua require("telescope.builtin").grep_string({ search = vim.fn.input("Grep ❯ ") })<CR>')
  map(M.modes.n, find.current_word,
      '<cmd>lua require("telescope.builtin").grep_string({ search = vim.fn.expand("<cword>") })<CR>')
  map(M.modes.n, find.wiki,
      '<cmd>lua require("telescope.builtin").grep_string({ cwd = "~/Dropbox/notes", search = vim.fn.input("Vimwiki ❯ ") })<CR>')


  -- EXECUTING THINGS --
  local execute = M.mappings.execute
  map(M.modes.n, execute.linkify,
      '<cmd>Linkify<CR>', { silent = true })


  -- IN SPECIFIC MODES --
  local specific_modes = M.mappings.specific_modes
  map(M.modes.s, specific_modes.ulti_jump,
      '<Esc>:call UltiSnips#JumpForwards()<CR>', { nowait = true, silent = true })
  -- Expand %% to the directory of the currently open file
  map(M.modes.c, specific_modes.expand_current_path,
      [[<C-R>=expand('%:h') . '/'<CR>]])
end


-- LSP MAPPINGS --
function M.setup_lsp(client, bufnr)
  local function buf_map(mode, lhs, rhs, opts)
    require('util').buf_map(bufnr, mode, lhs, rhs, opts)
  end

  -- -- VARIOUS --
  local various = M.mappings.various
  buf_map(M.modes.n, 'K',
      '<cmd>Lspsaga hover_doc<CR>')
  buf_map(M.modes.i, various.signature_help,
      '<cmd>lua require("lspsaga.signaturehelp").signature_help()<CR>')
  buf_map(M.modes.n, various.scroll_popup_down,
      '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(1)<CR>')
  buf_map(M.modes.n, various.scroll_popup_up,
      '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(-1)<CR>')


  -- FINDING --
  local find = M.mappings.find
  buf_map(M.modes.n, find.symbols,
      '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
  buf_map(M.modes.n, find.references,
      '<cmd>lua vim.lsp.buf.references()<CR>')


  -- -- GOING PLACES  --
  local go = M.mappings.go
  local unimpaired = M.mappings.unimpaired
  buf_map(M.modes.n, go.definition,
      '<cmd>lua vim.lsp.buf.definition()<CR>')
  buf_map(M.modes.n, go.declaration,
    '<cmd>lua vim.lsp.buf.declaration()<CR>')
  buf_map(M.modes.n, go.implementation,
      '<cmd>lua vim.lsp.buf.implementation()<CR>')
  buf_map(M.modes.n, go.type_definition,
      '<cmd>lua vim.lsp.buf.type_definition()<CR>')
  buf_map(M.modes.n, unimpaired.diagnostic_prev,
      '<cmd>Lspsaga diagnostic_jump_prev<CR>')
  buf_map(M.modes.n, unimpaired.diagnostic_next,
      '<cmd>Lspsaga diagnostic_jump_next<CR>')


  -- MAKE-ING --
  local make = M.mappings.make
  if client.resolved_capabilities.document_formatting then
    buf_map(M.modes.n, make.format,
        '<cmd>lua vim.lsp.buf.formatting()<CR>')
  elseif client.resolved_capabilities.document_range_formatting then
    buf_map(M.modes.n, make.format,
        '<cmd>lua vim.lsp.buf.range_formatting()<CR>')
  end


  -- REFACTORING --
  local refactor = M.mappings.refactor
  buf_map(M.modes.n, refactor.rename,
      '<cmd>lua vim.lsp.buf.rename()<CR>')
  buf_map(M.modes.n, refactor.code_action,
      '<cmd>Lspsaga code_action<CR>')
  buf_map(M.modes.v, refactor.code_action,
      '<cmd>Lspsaga range_code_action<CR>')


  -- SHOWING THINGS --
  local show = M.mappings.show
  buf_map(M.modes.n, show.signature_help,
      '<cmd>Lspsaga signature_help<CR>')
  buf_map(M.modes.n, show.diagnostic,
      '<cmd>Lspsaga show_cursor_diagnostics<CR>')
  buf_map(M.modes.n, show.diagnostic_line,
      '<cmd>Lspsaga show_line_diagnostics<CR>')
end


-- DAP MAPPINGS --
function M.setup_dap(bufnr)
  local function buf_map(mode, lhs, rhs, opts)
    require('util').buf_map(bufnr, mode, lhs, rhs, opts)
  end


  -- DEBUGGING --
  local debug = M.mappings.debug
  buf_map(M.modes.n, debug.toggle_repl,
      '<cmd>lua require("dap").repl.toggle()<CR>')
  buf_map(M.modes.n, debug.continue,
      '<cmd>lua require("dap").continue()<CR>')
  buf_map(M.modes.n, debug.step_into,
      '<cmd>lua require("dap").step_into()<CR>')
  buf_map(M.modes.n, debug.step_over,
      '<cmd>lua require("dap").step_over()<CR>')
  buf_map(M.modes.n, debug.step_out,
      '<cmd>lua require("dap").step_out()<CR>')
  buf_map(M.modes.n, debug.breakpoint,
      '<cmd>lua require("dap").toggle_breakpoint()<CR>')
  buf_map(M.modes.n, debug.run_last,
      '<cmd>lua require("dap").run_last()<CR>')


  -- SHOWING THINGS --
  local show = M.mappings.show
  buf_map(M.modes.n, show.debug_value,
      '<cmd>lua require("dap.ui.variables").hover()<CR>')
  buf_map(M.modes.v, show.debug_value,
      '<cmd>lua require("dap.ui.variables").visual_hover()<CR>')
end


function M.setup()
  define_commands()
  define_mappings()
end

return M
