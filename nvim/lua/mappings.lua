local This = {}

local map = require('vim-util').map

This.modes = { i = 'i', n = 'n', v = 'v', c = 'c', s = 's' }

This.mappings = {
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
    buffer_next         = ']b',
    buffer_prev         = '[b',
    diagnostic_next     = ']d',
    diagnostic_prev     = '[d',
    function_next       = ']]',
    function_prev       = '[[',
    quickfix_first      = '[Q',
    quickfix_last       = ']Q',
    quickfix_next       = ']q',
    quickfix_prev       = '[q'
  },
  toggles = {
    list                = '<leader><leader>l',
    tabstop_2           = '<leader><leader>2',
    tabstop_4           = '<leader><leader>4',
    tabstop_8           = '<leader><leader>8',
    tabstop_tab         = '<leader><leader><tab>',
    wrap                = '<leader><leader>w'
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
    symbols_workspace   = '<leader>fS',
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
    diagnostics         = '<leader>md',
    diagnostics_workspace = '<leader>mD',
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


-- MAPPINGS --
local function define_mappings()
  -- LEADER --
  vim.g.mapleader = ' '


  -- REMAPPING EXISTING KEYS TO MAKE THEM BETTER --
  -- Navigate the screen, not the lines, and update the jump list when the count > 5
  map(This.modes.n, 'j',
      [[v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj']], { expr = true })
  map(This.modes.n, 'k',
      [[v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk']], { expr = true })
  map(This.modes.v, 'j',
      [[v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj']], { expr = true })
  map(This.modes.v, 'k',
      [[v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk']], { expr = true })
  -- Keep the selection after re-indenting
  map(This.modes.v, '<',
      '<gv')
  map(This.modes.v, '>',
      '>gv')
  -- Center search matches
  map(This.modes.n, 'n',
      'nzz')
  map(This.modes.n, 'N',
      'Nzz')
  -- Toggle movements
  map(This.modes.n, ';',
      '<cmd>lua require("util").toggle_movement(";", "0;")<CR>')
  map(This.modes.n, ',',
      '<cmd>lua require("util").toggle_movement(",", "$,")<CR>')


  -- VARIOUS --
  local various = This.mappings.various
  map(This.modes.n, various.yank_to_clipboard,
      '"+y')
  map(This.modes.v, various.yank_to_clipboard,
      '"+y')
  map(This.modes.n, various.comment_line,
      '<Plug>CommentaryLine', { noremap = false })
  map(This.modes.v, various.comment,
      '<Plug>Commentary', { noremap = false })
  map(This.modes.n, various.vimwiki,
      '<cmd>VimwikiIndex<CR>')
  map(This.modes.n, various.close_everything,
      '<cmd>lua require("util").close_everything()<CR>', { silent = true })


  -- COMPLETION --
  _G.compe = require('completion')
  map(This.modes.i, '<Tab>',
      'v:lua.compe.tab_complete()', { expr = true })
  map(This.modes.i, '<S-Tab>',
      'v:lua.compe.s_tab_complete()', { expr = true })
  map(This.modes.i, '<CR>',
      'v:lua.compe.cr_complete()', { expr = true })


  -- UNIMPAIRED --
  local unimpaired = This.mappings.unimpaired
  map(This.modes.n, unimpaired.buffer_prev,
      '<cmd>bprevious<CR>')
  map(This.modes.n, unimpaired.buffer_next,
      '<cmd>bnext<CR>')
  map(This.modes.n, unimpaired.quickfix_first,
      '<cmd>cfirst<CR>')
  map(This.modes.n, unimpaired.quickfix_prev,
      '<cmd>cprevious<CR>')
  map(This.modes.n, unimpaired.quickfix_next,
      '<cmd>cnext<CR>')
  map(This.modes.n, unimpaired.quickfix_last,
      '<cmd>clast<CR>')


  -- TOGGLES --
  local toggles = This.mappings.toggles
  map(This.modes.n, toggles.tabstop_2,
      '<cmd>lua require("util").set_buf_indent(2, true)<CR>')
  map(This.modes.n, toggles.tabstop_4,
      '<cmd>lua require("util").set_buf_indent(4, true)<CR>')
  map(This.modes.n, toggles.tabstop_8,
      '<cmd>lua require("util").set_buf_indent(8, true)<CR>')
  map(This.modes.n, toggles.tabstop_tab,
      '<cmd>lua require("util").set_buf_indent(nil, true)<CR>')
  map(This.modes.n, toggles.list,
      '<cmd>set list! list?<CR>')
  map(This.modes.n, toggles.wrap,
      '<cmd>set wrap! wrap?<CR>')


  -- FINDING --
  local find = This.mappings.find
  map(This.modes.n, find.buffers,
      '<cmd>Telescope buffers show_all_buffers=true<CR>')
  map(This.modes.n, find.files,
      '<cmd>Telescope find_files<CR>')
  map(This.modes.n, find.identifier,
      '<cmd>Telescope treesitter<CR>')
  map(This.modes.n, find.tree,
      '<cmd>NvimTreeToggle<CR>')
  map(This.modes.n, find.tree_follow,
      '<cmd>NvimTreeFindFile<CR>')
  map(This.modes.n, find.grep,
      '<cmd>lua require("telescope.builtin").grep_string({ search = vim.fn.input("Grep ❯ ") })<CR>')
  map(This.modes.n, find.current_word,
      '<cmd>lua require("telescope.builtin").grep_string({ search = vim.fn.expand("<cword>") })<CR>')
  map(This.modes.n, find.wiki,
      '<cmd>lua require("telescope.builtin").grep_string({ cwd = "~/Dropbox/notes", search = vim.fn.input("Vimwiki ❯ ") })<CR>')


  -- EXECUTING THINGS --
  local execute = This.mappings.execute
  map(This.modes.n, execute.linkify,
      '<cmd>lua require("util").linkify()<CR>', { silent = true })


  -- IN SPECIFIC ThisODES --
  local specific_modes = This.mappings.specific_modes
  map(This.modes.s, specific_modes.ulti_jump,
      '<Esc>:call UltiSnips#JumpForwards()<CR>', { nowait = true, silent = true })
  -- Expand %% to the directory of the currently open file
  map(This.modes.c, specific_modes.expand_current_path,
      [[<C-R>=expand('%:h') . '/'<CR>]])
end


-- LSP MAPPINGS --
function This.setup_lsp(client, bufnr)
  local function buf_map(mode, lhs, rhs, opts)
    require('vim-util').buf_map(bufnr, mode, lhs, rhs, opts)
  end

  -- -- VARIOUS --
  local various = This.mappings.various
  buf_map(This.modes.n, 'K',
      '<cmd>Lspsaga hover_doc<CR>')
  buf_map(This.modes.i, various.signature_help,
      '<cmd>lua require("lspsaga.signaturehelp").signature_help()<CR>')
  buf_map(This.modes.n, various.scroll_popup_down,
      '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(1)<CR>')
  buf_map(This.modes.n, various.scroll_popup_up,
      '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(-1)<CR>')


  -- FINDING --
  local find = This.mappings.find
  buf_map(This.modes.n, find.symbols,
      '<cmd>Telescope lsp_document_symbols<CR>')
  buf_map(This.modes.n, find.symbols_workspace,
      '<cmd>Telescope lsp_workspace_symbols<CR>')
  buf_map(This.modes.n, find.references,
      '<cmd>Telescope lsp_references<CR>')


  -- GOING PLACES  --
  local go = This.mappings.go
  local unimpaired = This.mappings.unimpaired
  buf_map(This.modes.n, go.definition,
      '<cmd>lua vim.lsp.buf.definition()<CR>')
  buf_map(This.modes.n, go.declaration,
    '<cmd>lua vim.lsp.buf.declaration()<CR>')
  buf_map(This.modes.n, go.implementation,
      '<cmd>lua vim.lsp.buf.implementation()<CR>')
  buf_map(This.modes.n, go.type_definition,
      '<cmd>lua vim.lsp.buf.type_definition()<CR>')
  buf_map(This.modes.n, unimpaired.diagnostic_prev,
      '<cmd>Lspsaga diagnostic_jump_prev<CR>')
  buf_map(This.modes.n, unimpaired.diagnostic_next,
      '<cmd>Lspsaga diagnostic_jump_next<CR>')


  -- MAKE-ING --
  local make = This.mappings.make
  buf_map(This.modes.n, make.diagnostics,
      '<cmd>Telescope lsp_document_diagnostics<CR>')
  buf_map(This.modes.n, make.diagnostics_workspace,
      '<cmd>Telescope lsp_workspace_diagnostics<CR>')
  if client.resolved_capabilities.document_formatting then
    buf_map(This.modes.n, make.format,
        '<cmd>lua vim.lsp.buf.formatting()<CR>')
  elseif client.resolved_capabilities.document_range_formatting then
    buf_map(This.modes.n, make.format,
        '<cmd>lua vim.lsp.buf.range_formatting()<CR>')
  end


  -- REFACTORING --
  local refactor = This.mappings.refactor
  buf_map(This.modes.n, refactor.rename,
      '<cmd>lua vim.lsp.buf.rename()<CR>')
  buf_map(This.modes.n, refactor.code_action,
      '<cmd>Telescope lsp_code_actions<CR>')
  buf_map(This.modes.v, refactor.code_action,
      '<cmd>Telescope lsp_range_code_actions<CR>')


  -- SHOWING THINGS --
  local show = This.mappings.show
  buf_map(This.modes.n, show.signature_help,
      '<cmd>Lspsaga signature_help<CR>')
  buf_map(This.modes.n, show.diagnostic,
      '<cmd>Lspsaga show_cursor_diagnostics<CR>')
  buf_map(This.modes.n, show.diagnostic_line,
      '<cmd>Lspsaga show_line_diagnostics<CR>')
end


-- DAP MAPPINGS --
function This.setup_dap(bufnr)
  local function buf_map(mode, lhs, rhs, opts)
    require('vim-util').buf_map(bufnr, mode, lhs, rhs, opts)
  end


  -- DEBUGGING --
  local debug = This.mappings.debug
  buf_map(This.modes.n, debug.toggle_repl,
      '<cmd>lua require("dap").repl.toggle()<CR>')
  buf_map(This.modes.n, debug.continue,
      '<cmd>lua require("dap").continue()<CR>')
  buf_map(This.modes.n, debug.step_into,
      '<cmd>lua require("dap").step_into()<CR>')
  buf_map(This.modes.n, debug.step_over,
      '<cmd>lua require("dap").step_over()<CR>')
  buf_map(This.modes.n, debug.step_out,
      '<cmd>lua require("dap").step_out()<CR>')
  buf_map(This.modes.n, debug.breakpoint,
      '<cmd>lua require("dap").toggle_breakpoint()<CR>')
  buf_map(This.modes.n, debug.run_last,
      '<cmd>lua require("dap").run_last()<CR>')


  -- SHOWING THINGS --
  local show = This.mappings.show
  buf_map(This.modes.n, show.debug_value,
      '<cmd>lua require("dap.ui.variables").hover()<CR>')
  buf_map(This.modes.v, show.debug_value,
      '<cmd>lua require("dap.ui.variables").visual_hover()<CR>')
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

  -- plugin management
  vim.api.nvim_exec([[
    command! PlugLock execute 'PlugSnapshot! ' . g:plugin_lockfile
    command! PlugRevert execute 'source ' . g:plugin_lockfile
  ]], false)
end


function This.setup()
  define_mappings()
  define_commands()
end

return This
