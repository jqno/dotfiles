local This = {}

local map = require('vim-util').map
local wk = require('which-key').register


This.modes = { i = 'i', n = 'n', v = 'v', c = 'c', s = 's' }


function This.whichkey_checkduplicates()
  local dups = require('which-key.keys').duplicates
  if vim.tbl_count(dups) > 0 then
    vim.cmd('echoerr "Duplicate mapping detected - do :checkhealth"')
  end
end


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
  map(This.modes.n, 'Y',
      '"+y')
  map(This.modes.v, 'Y',
      '"+y')
  map(This.modes.n, '\\\\',
      '<Plug>CommentaryLine', { noremap = false })
  map(This.modes.v, '\\',
      '<Plug>Commentary', { noremap = false })


  -- COMPLETION --
  _G.compe = require('completion')
  map(This.modes.i, '<Tab>',
      'v:lua.compe.tab_complete()', { expr = true })
  map(This.modes.i, '<S-Tab>',
      'v:lua.compe.s_tab_complete()', { expr = true })
  map(This.modes.i, '<CR>',
      'v:lua.compe.cr_complete()', { expr = true })


  -- IN SPECIFIC MODES --
  map(This.modes.n, '<F12>',
      '<cmd>VimwikiMakeDiaryNote<CR>')
  map(This.modes.s, '<C-L>',
      '<Esc>:call UltiSnips#JumpForwards()<CR>', { nowait = true, silent = true })
  -- Expand %% to the directory of the currently open file
  map(This.modes.c, '%%',
      [[<C-R>=expand('%:h') . '/'<CR>]])


  wk({
    -- UNIMPAIRED --
    ['['] = {
      name = 'previous',
      ['['] = 'function',
      b = { '<cmd>bprevious<CR>', 'buffer' },
      g = 'git hunk',
      q = { '<cmd>cprevious<CR>', 'quickfix' },
      Q = { '<cmd>qfirst<CR>', 'quickfix first' },
      w = { '<cmd>VimwikiDiaryPrevDay<CR>', 'diary' }
    },
    [']'] = {
      name = 'next',
      [']'] = 'function',
      b = { '<cmd>bnext<CR>', 'buffer' },
      g = 'git hunk',
      Q = { '<cmd>clast<CR>', 'quickfix last' },
      q = { '<cmd>cnext<CR>', 'quickfix' },
      w = { '<cmd>VimwikiDiaryNextDay<CR>', 'diary' },
    },
    -- RAW LEADER --
    ['<leader>'] = {
      ['<esc>'] = { '<cmd>lua require("util").close_everything()<CR>', 'close everything', silent = true },
      -- defined elsewhere
      ['<C-D>'] = 'scroll down',
      ['<C-U>'] = 'scroll up'
    },
    -- TOGGLES --
    ['<leader><leader>'] = {
      name = 'toggles',
      ['2'] = { '<cmd>lua require("util").set_buf_indent(2, true)<CR>', 'indent 2' },
      ['4'] = { '<cmd>lua require("util").set_buf_indent(4, true)<CR>', 'indent 4' },
      ['8'] = { '<cmd>lua require("util").set_buf_indent(8, true)<CR>', 'indent 8' },
      ['<tab>'] = { '<cmd>lua require("util").set_buf_indent(nil, true)<CR>', 'indent tab' },
      l = { '<cmd>set list! list?<CR>', 'list' },
      w = { '<cmd>set wrap! wrap?<CR>', 'wrap' }
    },
    -- BUFFER --
    ['<leader>b'] = {
      name = 'buffer',
      d = { '<cmd>bd<CR>', 'delete' }
    },
    ['<leader>d'] = {
      name = 'debug'
    },
    -- EXECUTING THINGS --
    ['<leader>x'] = {
      name = 'execute',
      l = { '<cmd>lua require("util").linkify()<CR>', 'linkify', silent = true }
    },
    -- FINDING --
    ['<leader>f'] = {
      name = 'file',
      b = { '<cmd>Telescope buffers show_all_buffers=true<CR>', 'buffers' },
      f = { '<cmd>Telescope find_files<CR>', 'files' },
      i = { '<cmd>Telescope treesitter<CR>', 'identifiers' },
      n = { '<cmd>NvimTreeToggle<CR>', 'tree' },
      N = { '<cmd>NvimTreeFindFile<CR>', 'tree (follow)' },
      g = { '<cmd>lua require("telescope.builtin").grep_string({ search = vim.fn.input("Grep ❯ ") })<CR>', 'grep' },
      w = { '<cmd>lua require("telescope.builtin").grep_string({ cwd = "~/Dropbox/notes", search = vim.fn.input("Vimwiki ❯ ") })<CR>', 'wiki' },
      ['*'] = { '<cmd>lua require("telescope.builtin").grep_string({ search = vim.fn.expand("<cword>") })<CR>', 'grep current' }
    },
    -- GOING PLACES  --
    ['<leader>g'] = {
      name = 'go'
    },
    -- GIT --
    ['<leader>G'] = {
      name = 'Git',
      b = 'blame line',
      p = 'preview hunk',
      R = 'reset buffer',
      r = 'reset hunk',
      s = 'stage hunk',
      u = 'undo stage hunk'
    },
    -- MAKE-ING --
    ['<leader>m'] = {
      name = 'make'
    },
    -- REFACTORING --
    ['<leader>r'] = {
      name = 'refactor',
      ['>'] = 'swap next',
      ['<'] = 'swap prev'
    },
    -- SHOWING THINGS --
    ['<leader>s'] = {
      name = 'show',
      c = 'peek class',
      f = 'peek function'
    },
    -- WIKI --
    ['<leader>w'] = {
      name = 'wiki',
      d = { '<cmd>VimwikiDiaryIndex<CR>', 'diary index' },
      g = { '<cmd>VimwikiDiaryGenerateLinks<CR>', 'generate diary' },
      n = { '<cmd>VimwikiMakeDiaryNote<CR>', 'today' },
      w = { '<cmd>VimwikiIndex<CR>', 'index' },
      x = 'additional'
    },
    -- WINDOW --
    ['<leader>W'] = {
      name = 'window',
      ['='] = { '<cmd>wincmd =<CR>', 'equalize' },
      ['0'] = { '<cmd>wincmd r<CR>', 'rotate' },
      z = { '<cmd>ZenMode<CR>', 'zoom' }
    }
  })
end


-- LSP MAPPINGS --
function This.setup_lsp(client, bufnr)
  local function buf_map(mode, lhs, rhs, opts)
    require('vim-util').buf_map(bufnr, mode, lhs, rhs, opts)
  end

  -- VARIOUS --
  buf_map(This.modes.n, 'K',
      '<cmd>Lspsaga hover_doc<CR>')
  buf_map(This.modes.i, '<C-Space>',
      '<cmd>lua require("lspsaga.signaturehelp").signature_help()<CR>')
  buf_map(This.modes.n, '<leader><C-D>',
      '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(1)<CR>')
  buf_map(This.modes.n, '<leader><C-U>',
      '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(-1)<CR>')

  wk({
    -- UNIMPAIRED --
    ['['] = {
      d = { '<cmd>Lspsaga diagnostic_jump_prev<CR>', 'diagnostic' }
    },
    [']'] = {
      d = { '<cmd>Lspsaga diagnostic_jump_next<CR>', 'diagnostic' }
    },
    -- FINDING --
    ['<leader>f'] = {
      s = { '<cmd>Telescope lsp_document_symbols<CR>', 'document symbols' },
      S = { '<cmd>Telescope lsp_workspace_symbols<CR>', 'workspace symbols' },
      r = { '<cmd>Telescope lsp_references<CR>', 'references' }
    },
    -- GOING PLACES  --
    ['<leader>g'] = {
      [']'] = { '<cmd>lua vim.lsp.buf.definition()<CR>', 'definition' },
      d = { '<cmd>lua vim.lsp.buf.declaration()<CR>', 'declaration' },
      i = { '<cmd>lua vim.lsp.buf.implementation()<CR>', 'implementation' },
      t = { '<cmd>lua vim.lsp.buf.type_definition()<CR>', 'type definition' }
    },
    -- MAKE-ING --
    ['<leader>m'] = {
      d = { '<cmd>Telescope lsp_document_diagnostics<CR>', 'show diagnostics' },
      D = { '<cmd>Telescope lsp_workspace_diagnostics<CR>', 'show ALL diagnostics' },
    },
    -- REFACTORING --
    ['<leader>r'] = {
      ['<CR>'] = { '<cmd>Telescope lsp_code_actions<CR>', 'code actions' },
      r = { '<cmd>lua vim.lsp.buf.rename()<CR>', 'rename' },
    },
    -- SHOWING THINGS --
    ['<leader>s'] = {
      s = { '<cmd>Lspsaga signature_help<CR>', 'signature help' },
      d = { '<cmd>Lspsaga show_cursor_diagnostics<CR>', 'diagnostics' },
      D = { '<cmd>Lspsaga show_line_diagnostics<CR>', 'line diagnostics' }
    }
  }, { buffer = bufnr })


  local ft = vim.fn.getbufvar(bufnr, '&filetype')
  if ft ~= 'java' then
    -- Java is going to override the formating mapping later
    if client.resolved_capabilities.document_formatting then
      wk({
        ['<leader>m'] = {
          f = { '<cmd>lua vim.lsp.buf.formatting()<CR>', 'format' }
        }
      }, { buffer = bufnr })
    elseif client.resolved_capabilities.document_range_formatting then
      wk({
        ['<leader>m'] = {
          f = { '<cmd>lua vim.lsp.buf.range_formatting()<CR>', 'format' }
        }
      }, { buffer = bufnr })
    end
  end

  -- VISUAL MODE --
  wk({
    -- REFACTORING --
    ['<leader>r'] = {
      name = 'refactor',
      ['<CR>'] = { '<cmd>Telescope lsp_range_code_actions<CR>', 'code actions' },
    }
  }, { buffer = bufnr, mode = This.modes.v })
end


-- DAP MAPPINGS --
function This.setup_dap(bufnr)
  wk({
    -- DEBUGGING --
    ['<leader>d'] = {
      ['<space>'] = { '<cmd>lua require("dap").repl.toggle()<CR>', 'toggle repl' },
      b = { '<cmd>lua require("dap").toggle_breakpoint()<CR>', 'breakpoint' },
      c = { '<cmd>lua require("dap").continue()<CR>', 'continue' },
      i = { '<cmd>lua require("dap").step_into()<CR>', 'step into' },
      l = { '<cmd>lua require("dap").run_last()<CR>', 'run last' },
      o = { '<cmd>lua require("dap").step_over()<CR>', 'step over' },
      x = { '<cmd>lua require("dap").step_out()<CR>', 'step out' }
    },
    -- SHOWING THINGS --
    ['<leader>s'] = {
      v = { '<cmd>lua require("dap.ui.variables").hover()<CR>', 'debug value' }
    }
  }, { buffer = bufnr })


  -- VISUAL --
  wk({
    ['<leader>s'] = {
      name = 'show',
      v = { '<cmd>lua require("dap.ui.variables").visual_hover()<CR>', 'debug value' }
    }
  }, { buffer = bufnr, mode = This.modes.v })
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

  require('vim-util').augroup('whichkey-duplicates', [[
    autocmd BufNew * lua require('mappings').whichkey_checkduplicates()
  ]])
end


return This
