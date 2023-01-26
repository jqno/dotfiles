local This = {}

local map = vim.keymap.set

This.modes = { i = 'i', n = 'n', v = 'v', c = 'c', s = 's', t = 't' }

-- MAPPINGS --
local function define_mappings()
    -- LEADER --
    vim.g.mapleader = ' '

    -- REMAPPING EXISTING KEYS TO MAKE THEM BETTER --
    -- Navigate the screen, not the lines, and update the jump list when the count > 5
    map(This.modes.n, 'j',
        [[v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj']],
        { expr = true })
    map(This.modes.n, 'k',
        [[v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk']],
        { expr = true })
    -- Easy window switching
    map(This.modes.n, '<C-h>', '<C-w>h')
    map(This.modes.n, '<C-j>', '<C-w>j')
    map(This.modes.n, '<C-k>', '<C-w>k')
    map(This.modes.n, '<C-l>', '<C-w>l')
    -- Keep the selection after re-indenting
    map(This.modes.v, '<', '<gv')
    map(This.modes.v, '>', '>gv')
    -- Center search matches
    map(This.modes.n, 'n', 'nzz')
    map(This.modes.n, 'N', 'Nzz')
    -- Toggle movements
    map(This.modes.n, '0',
        function() require('util').toggle_movement('^', '0') end, { desc = 'toggle movement 0' })
    map(This.modes.n, ';',
        function() require('util').toggle_movement(';', '0;') end, { desc = 'toggle movement ;' })
    map(This.modes.n, ',',
        function() require('util').toggle_movement(',', '$,') end, { desc = 'toggle movement ,' })
    -- Breakpoints for undo
    map(This.modes.i, '.', '.<C-G>u')
    map(This.modes.i, ',', ',<C-G>u')
    map(This.modes.i, ';', ';<C-G>u')
    map(This.modes.i, '!', '!<C-G>u')
    map(This.modes.i, '?', '?<C-G>u')
    -- Copy to system clipboard
    map(This.modes.n, 'Y', '"+y')
    map(This.modes.v, 'Y', '"+y')
    -- Comment lines
    map(This.modes.n, '\\\\', '<Plug>CommentaryLine')
    map(This.modes.v, '\\', '<Plug>Commentary')
    -- Moving lines and blocks
    map(This.modes.n, '<M-j>', '<cmd>move .+1<CR>==')
    map(This.modes.n, '<M-k>', '<cmd>move .-2<CR>==')
    map(This.modes.v, '<M-j>', [[:move '>+1<CR>gv=gv]])
    map(This.modes.v, '<M-k>', [[:move '<-2<CR>gv=gv]])

    -- Close everything --
    map(This.modes.n, '<C-Esc>', function() require('util').close_everything() end,
        { desc = 'Close everything' })
    map(This.modes.t, '<C-Esc>', '<cmd>FloatermHide<CR>', { desc = 'Close everything' })

    -- Snippets and jumps --
    map(This.modes.i, '<C-L>',
        [[luasnip#expand_or_locally_jumpable() ? '<cmd>lua require("luasnip").expand_or_jump()<CR>' : JqnoAutocloseSmartJump()]]
        ,
        { expr = true, replace_keycodes = false })
    map(This.modes.s, '<C-L>',
        [[luasnip#expand_or_locally_jumpable() ? '<cmd>lua require("luasnip").expand_or_jump()<CR>' : '<C-L>']],
        { expr = true, replace_keycodes = false })
    map(This.modes.i, '<C-J>',
        [[luasnip#choice_active() ? '<cmd>lua require("luasnip").change_choice(1)<CR>' : '<C-J>']],
        { expr = true, replace_keycodes = false })
    map(This.modes.s, '<C-J>',
        [[luasnip#choice_active() ? '<cmd>lua require("luasnip").change_choice(1)<CR>' : '<C-J>']],
        { expr = true, replace_keycodes = false })
    map(This.modes.i, '<C-K>',
        [[luasnip#choice_active() ? '<cmd>lua require("luasnip").change_choice(-1)<CR>' : '<C-K>']],
        { expr = true, replace_keycodes = false })
    map(This.modes.s, '<C-K>',
        [[luasnip#choice_active() ? '<cmd>lua require("luasnip").change_choice(-1)<CR>' : '<C-K>']],
        { expr = true, replace_keycodes = false })
    -- Expand %% to the directory of the currently open file
    map(This.modes.c, '%%', [[<C-R>=expand('%:h') . '/'<CR>]])

    -- UNIMPAIRED --
    map(This.modes.n, '[b', '<cmd>bprevious<CR>', { desc = 'go to previous buffer' })
    map(This.modes.n, '[q', '<cmd>cprevious<CR>', { desc = 'go to previous quickfix' })
    map(This.modes.n, '[Q', '<cmd>qfirst<CR>', { desc = 'go to first quickfix' })
    map(This.modes.n, ']b', '<cmd>bprevious<CR>', { desc = 'go to next buffer' })
    map(This.modes.n, ']q', '<cmd>cprevious<CR>', { desc = 'go to next quickfix' })
    map(This.modes.n, ']Q', '<cmd>qfirst<CR>', { desc = 'go to last quickfix' })

    -- NAVIGATION --
    map(This.modes.n, '<leader><leader><leader>', function() require('harpoon.ui').toggle_quick_menu() end,
        { desc = 'open Harpoon quick list' })
    map(This.modes.n, '<leader><leader><CR>', function() require('util').open_alternate() end,
        { desc = 'open alternate here' })
    map(This.modes.n, '<leader><leader>1', function() require('harpoon.ui').nav_file(1) end,
        { desc = 'navigate to Harpoon file #1' })
    map(This.modes.n, '<leader><leader>2', function() require('harpoon.ui').nav_file(2) end,
        { desc = 'navigate to Harpoon file #2' })
    map(This.modes.n, '<leader><leader>3', function() require('harpoon.ui').nav_file(3) end,
        { desc = 'navigate to Harpoon file #3' })
    map(This.modes.n, '<leader><leader>4', function() require('harpoon.ui').nav_file(4) end,
        { desc = 'navigate to Harpoon file #4' })
    map(This.modes.n, '<leader><leader>5', function() require('harpoon.ui').nav_file(5) end,
        { desc = 'navigate to Harpoon file #5' })
    map(This.modes.n, '<leader><leader>h', function() require('util').open_split('left') end,
        { desc = 'open split left' })
    map(This.modes.n, '<leader><leader>j', function() require('util').open_split('down') end,
        { desc = 'open split below' })
    map(This.modes.n, '<leader><leader>k', function() require('util').open_split('up') end,
        { desc = 'open split above' })
    map(This.modes.n, '<leader><leader>l', function() require('util').open_split('right') end,
        { desc = 'open split right' })
    map(This.modes.n, '<leader><leader>m', function() require('harpoon.mark').add_file() end,
        { desc = 'add file to Harpoon list' })
    map(This.modes.n, '<leader><leader>H', function() require('util').open_alternate('left') end,
        { desc = 'open alternate file left' })
    map(This.modes.n, '<leader><leader>J', function() require('util').open_alternate('down') end,
        { desc = 'open alternate file down' })
    map(This.modes.n, '<leader><leader>K', function() require('util').open_alternate('up') end,
        { desc = 'open alternate file up' })
    map(This.modes.n, '<leader><leader>L', function() require('util').open_alternate('right') end,
        { desc = 'open alternate file right' })

    -- FOLLOW REFERENCES --
    map(This.modes.n, '<leader>]h', function() require('util').open_definition('left') end,
        { desc = 'follow reference left' })
    map(This.modes.n, '<leader>]j', function() require('util').open_definition('down') end,
        { desc = 'follow reference down' })
    map(This.modes.n, '<leader>]k', function() require('util').open_definition('up') end,
        { desc = 'follow reference up' })
    map(This.modes.n, '<leader>]l', function() require('util').open_definition('right') end,
        { desc = 'follow reference right' })

    -- TOGGLES --
    map(This.modes.n, '<leader>t2', function() require('util').set_buf_indent(2, false, true) end,
        { desc = 'toggle indent: 2 spaces' })
    map(This.modes.n, '<leader>t4', function() require('util').set_buf_indent(4, false, true) end,
        { desc = 'toggle indent: 4 spaces' })
    map(This.modes.n, '<leader>t8', function() require('util').set_buf_indent(8, false, true) end,
        { desc = 'toggle indent: 8 spaces' })
    map(This.modes.n, '<leader>t<tab>', function() require('util').set_buf_indent(4, true, true) end,
        { desc = 'toggle indent: tabs' })
    map(This.modes.n, '<leader>tl', '<cmd>set list! list?<CR>', { desc = 'toggle visible spaces' })
    map(This.modes.n, '<leader>ts', '<cmd>exec "set scrolloff=" . (102 - &scrolloff)<CR>',
        { desc = 'toggle typewriter scroll mode' })
    map(This.modes.n, '<leader>tw', '<cmd>set wrap! wrap?<CR>', { desc = 'toggle wrap' })
    map(This.modes.n, '<leader>tz', '<cmd>ZenMode<CR>', { desc = 'toggle zen mode' })

    -- BUFFER --
    map(This.modes.n, '<leader>bb', '<cmd>b#<CR>', { desc = 'go to previous buffer' })
    map(This.modes.n, '<leader>bd', '<cmd>BufDel<CR>', { desc = 'delete current buffer' })
    map(This.modes.n, '<leader>bx', '<cmd>bufdo bdelete<CR>', { desc = 'close all buffers' })

    -- EXECUTING THINGS --
    map(This.modes.n, '<leader>xl', function() require('util').linkify() end,
        { desc = 'linkify', silent = true })
    map(This.modes.n, '<leader>xn', function() require('util').show_full_path() end,
        { desc = 'show full path', silent = true })

    -- FINDING --
    map(This.modes.n, '<leader>fb', '<cmd>Telescope buffers show_all_buffers=true<CR>', { desc = 'find buffers' })
    map(This.modes.n, '<leader>fd', '<cmd>Telescope diagnostics bufnr=0<CR>', { desc = 'find diagnostics' })
    map(This.modes.n, '<leader>fD', '<cmd>Telescope diagnostics<CR>', { desc = 'find workspace diagnostics' })
    map(This.modes.n, '<leader>ff',
        '<cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files,--glob,!.git/*<CR>', { desc = 'find files' })
    map(This.modes.n, '<leader>fh', '<cmd>Telescope help_tags<CR>', { desc = 'find help item' })
    map(This.modes.n, '<leader>fi', '<cmd>Telescope treesitter<CR>', { desc = 'find treesitter identifiers' })
    map(This.modes.n, '<leader>fn', '<cmd>NvimTreeFindFileToggle<CR>', { desc = 'open file tree' })
    map(This.modes.n, '<leader>fg',
        function() require('telescope.builtin').grep_string({ search = vim.fn.input('Grep ❯ ') }) end,
        { desc = 'grep in workspace' })
    map(This.modes.n, '<leader>f*',
        function() require('telescope.builtin').grep_string({ search = vim.fn.expand('<cword>') }) end,
        { desc = 'grep current wordt in workspace' })
    map(This.modes.n, '<leader>f:', '<cmd>Telescope commands<CR>', { desc = 'find Vim command' })
    map(This.modes.n, '<leader>fm', '<cmd>Telescope keymaps<CR>', { desc = 'find Vim mapping' })

    -- GIT --
    map(This.modes.n, '<leader>GB', '<cmd>Git blame<CR>', { desc = 'Git blame file' })
    map(This.modes.n, '<leader>Gh', '<cmd>0Gclog<CR>', { desc = 'show Git file history' })

    -- MAKE-ING --
    map(This.modes.n, '<leader>m<CR>', '<cmd>TestLast<CR>', { desc = 'run last test' })
    map(This.modes.n, '<leader>mt', '<cmd>TestNearest<CR>', { desc = 'run nearest test' })
    map(This.modes.n, '<leader>mT', '<cmd>TestFile<CR>', { desc = 'test current file' })

    -- WINDOW --
    map(This.modes.n, '<leader>w_', '<cmd>wincmd _<CR>', { desc = 'enlarge window' })
    map(This.modes.n, '<leader>w=', '<cmd>wincmd =<CR>', { desc = 'equalize windows' })
    map(This.modes.n, '<leader>w0', '<cmd>wincmd r<CR>', { desc = 'rotate windows' })
    map(This.modes.n, '<leader>wk', '<C-w>w', { desc = 'move into floating window' })
    map(This.modes.n, '<leader>ww', '<cmd>SwapSplit<CR>', { desc = 'swap windows' })

    -- TERMINAL --
    map(This.modes.n, '<C-CR>', '<cmd>FloatermToggle<CR>')
    map(This.modes.t, '<C-CR>', '<cmd>FloatermHide<CR>')
    map(This.modes.t, '<S-Esc>', '<C-\\><C-N>')
    map(This.modes.t, '<C-H>', '<C-\\><C-N><C-W>h')
    map(This.modes.t, '<C-J>', '<C-\\><C-N><C-W>j')
    map(This.modes.t, '<C-K>', '<C-\\><C-N><C-W>k')
    map(This.modes.t, '<C-L>', '<C-\\><C-N><C-W>l')
    map(This.modes.t, '<C-\\>t', '<cmd>FloatermToggle<CR>', { desc = 'toggle terminal' })
end

-- LSP MAPPINGS --
function This.setup_lsp_diagnostics_and_formatting(client, bufnr)
    -- UNIMPAIRED --
    map(This.modes.n, '[d', function() vim.diagnostic.goto_prev({ source = 'always' }) end,
        { buffer = bufnr, desc = 'go to previous diagnostic' })
    map(This.modes.n, ']d', function() vim.diagnostic.goto_next({ source = 'always' }) end,
        { buffer = bufnr, desc = 'go to next diagnostic' })

    -- MAKE-ING --
    map(This.modes.n, '<leader>md', '<cmd>Telescope lsp_document_diagnostics<CR>',
        { buffer = bufnr, desc = 'show file diagnostics' })
    map(This.modes.n, '<leader>mD', '<cmd>Telescope lsp_workspace_diagnostics<CR>',
        { buffer = bufnr, desc = 'show workspace diagnostics' })

    -- SHOWING THINGS --
    map(This.modes.n, '<leader>sd', function() vim.diagnostic.open_float() end,
        { buffer = bufnr, desc = 'show diagnostic under cursor' })

    if client.server_capabilities.documentFormattingProvider then
        map(This.modes.n, '<leader>mf', function() vim.lsp.buf.format() end,
            { buffer = bufnr, desc = 'format current file' })
    end
end

function This.setup_lsp(client, bufnr)
    This.setup_lsp_diagnostics_and_formatting(client, bufnr)

    -- VARIOUS --
    map(This.modes.n, 'K', function() vim.lsp.buf.hover() end, { buffer = bufnr, silent = true })
    map(This.modes.i, '<C-Space>', function() vim.lsp.buf.signature_help() end, { buffer = bufnr, silent = true })

    -- FINDING --
    map(This.modes.n, '<leader>fs', '<cmd>Telescope lsp_document_symbols<CR>',
        { buffer = bufnr, desc = 'find current file symbols' })
    map(This.modes.n, '<leader>fS', '<cmd>Telescope lsp_workspace_symbols<CR>',
        { buffer = bufnr, desc = 'find workspace symbols' })
    map(This.modes.n, '<leader>fr', '<cmd>Telescope lsp_references<CR>', { buffer = bufnr, desc = 'references' })

    -- GOING PLACES  --
    map(This.modes.n, '<leader>gd', function() vim.lsp.buf.declaration() end,
        { buffer = bufnr, desc = 'go to declaration' })
    map(This.modes.n, '<leader>gi', function() vim.lsp.buf.implementation() end,
        { buffer = bufnr, desc = 'go to implementation' })
    map(This.modes.n, '<leader>gt', function() vim.lsp.buf.type_definition() end,
        { buffer = bufnr, desc = 'go to type definition' })

    -- REFACTORING --
    map(This.modes.n, '<leader>r<CR>', function() vim.lsp.buf.code_action() end,
        { buffer = bufnr, desc = 'show code actions' })
    map(This.modes.v, '<leader>r<CR>', function() vim.lsp.buf.code_action() end,
        { buffer = bufnr, desc = 'show code actions' })
    map(This.modes.n, '<leader>rr', function() vim.lsp.buf.rename() end, { buffer = bufnr, desc = 'refactor: rename' })

    -- SHOWING THINGS --
    map(This.modes.n, '<leader>ss', function() vim.lsp.buf.signature_help() end,
        { buffer = bufnr, desc = 'show signature help' })
end

-- DAP MAPPINGS --
function This.setup_dap(bufnr)
    -- DEBUGGING --
    map(This.modes.n, '<leader>d<space>', function() require('dap').repl.toggle() end,
        { buffer = bufnr, desc = 'debug: toggle repl' })
    map(This.modes.n, '<leader>db', function() require('dap').toggle_breakpoint() end,
        { buffer = bufnr, desc = 'debug: toggle breakpoint' })
    map(This.modes.n, '<leader>dc', function() require('dap').continue() end,
        { buffer = bufnr, desc = 'debug: continue' })
    map(This.modes.n, '<leader>di', function() require('dap').step_into() end,
        { buffer = bufnr, desc = 'debug: step into' })
    map(This.modes.n, '<leader>dl', function() require('dap').run_last() end,
        { buffer = bufnr, desc = 'debug: run last' })
    map(This.modes.n, '<leader>do', function() require('dap').step_over() end,
        { buffer = bufnr, desc = 'debug: step over' })
    map(This.modes.n, '<leader>dx', function() require('dap').step_out() end,
        { buffer = bufnr, desc = 'debug: step out' })

    -- SHOWING THINGS --
    map(This.modes.n, '<leader>sv', function() require('dap.ui.widgets').hover() end,
        { buffer = bufnr, desc = 'debug: show value' })
    map(This.modes.v, '<leader>sv', function() require('dap.ui.variables').visual_hover() end,
        { buffer = bufnr, desc = 'debug: show value' })
end

-- COMMANDS --
local function define_commands()
    -- prevent silly shift-pressing mistakes
    vim.cmd([[
        command! -bang -nargs=* -complete=file E e<bang> <args>
        command! -bang -nargs=* -complete=file W w<bang> <args>
        command! -bang -nargs=* -complete=file Wq wq<bang> <args>
        command! -bang -nargs=* -complete=file WQ wq<bang> <args>
        command! -bang Wa wa<bang>
        command! -bang WA wa<bang>
        command! -bang Q q<bang>
        command! -bang QA qa<bang>
        command! -bang Qa qa<bang>
    ]])

    -- plugin management
    vim.cmd([[
        command! PlugLock execute 'PlugSnapshot! ' . g:plugin_lockfile
        command! PlugRevert execute 'source ' . g:plugin_lockfile
    ]])
end

function This.setup()
    define_mappings()
    define_commands()
end

return This
