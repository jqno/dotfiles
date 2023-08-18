local This = {}

local map = vim.keymap.set
local modes = require('util.modes')
local floaterm = require('util.floaterm')

local function define_mappings()
    -- REMAPPING EXISTING KEYS TO MAKE THEM BETTER --
    -- Navigate the screen, not the lines, and update the jump list when the count > 5
    map(modes.n, 'j',
        [[v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj']],
        { expr = true })
    map(modes.n, 'k',
        [[v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk']],
        { expr = true })
    -- Center after moving around
    map(modes.n, 'n', 'nzz')
    map(modes.n, 'N', 'Nzz')
    map(modes.n, '<C-U>', '<C-U>zz')
    map(modes.n, '<C-D>', '<C-D>zz')
    -- Keep the selection after re-indenting
    map(modes.v, '<', '<gv')
    map(modes.v, '>', '>gv')
    -- Toggle movements
    map(modes.n, '0',
        function() require('util.toggle-movement').toggle_movement('^', '0') end,
        { desc = 'toggle movement 0' })
    map(modes.n, ';',
        function() require('util.toggle-movement').toggle_movement(';', '0;') end,
        { desc = 'toggle movement ;' })
    map(modes.n, ',',
        function() require('util.toggle-movement').toggle_movement(',', '$,') end,
        { desc = 'toggle movement ,' })
    -- Breakpoints for undo
    map(modes.i, '.', '.<C-G>u')
    map(modes.i, ',', ',<C-G>u')
    map(modes.i, ';', ';<C-G>u')
    map(modes.i, '!', '!<C-G>u')
    map(modes.i, '?', '?<C-G>u')
    -- Delete entire words
    map(modes.i, '<C-BS>', '<Esc>cvb')
    -- Copy to system clipboard
    map(modes.n, 'Y', '"+y')
    map(modes.v, 'Y', '"+y')

    -- VARIOUS MAPPINGS --
    -- Comment lines
    map(modes.n, '\\\\', '<Plug>CommentaryLine')
    map(modes.v, '\\', '<Plug>Commentary')

    -- Moving lines and blocks
    map(modes.n, '<M-j>', '<cmd>move .+1<CR>==')
    map(modes.n, '<M-k>', '<cmd>move .-2<CR>==')
    map(modes.v, '<M-j>', [[:move '>+1<CR>gv=gv]])
    map(modes.v, '<M-k>', [[:move '<-2<CR>gv=gv]])

    -- Easy window switching
    map(modes.n, '<C-h>', '<C-w>h')
    map(modes.n, '<C-j>', '<C-w>j')
    map(modes.n, '<C-k>', '<C-w>k')
    map(modes.n, '<C-l>', '<C-w>l')

    -- Close everything --
    map(modes.n, '<C-Esc>', require('util.close-everything').close_everything, { desc = 'Close everything' })
    map(modes.t, '<C-Esc>', vim.cmd.FloatermHide, { desc = 'Close everything' })

    -- Snippets and jumps --
    map(modes.i, '<C-L>',
        [[luasnip#expand_or_locally_jumpable() ? '<cmd>lua require("luasnip").expand_or_jump()<CR>' : JqnoAutocloseSmartJump()]]
        ,
        { expr = true, replace_keycodes = false })
    map(modes.s, '<C-L>',
        [[luasnip#expand_or_locally_jumpable() ? '<cmd>lua require("luasnip").expand_or_jump()<CR>' : '<C-L>']],
        { expr = true, replace_keycodes = false })
    map(modes.i, '<C-H>',
        [[luasnip#jumpable(-1) ? '<cmd>lua require("luasnip").jump(-1)<CR>' : '<C-H>']],
        { expr = true, replace_keycodes = false })
    map(modes.s, '<C-H>',
        [[luasnip#jumpable(-1) ? '<cmd>lua require("luasnip").jump(-1)<CR>' : '<C-H>']],
        { expr = true, replace_keycodes = false })
    map(modes.i, '<C-J>',
        [[luasnip#choice_active() ? '<cmd>lua require("luasnip").change_choice(1)<CR>' : '<C-J>']],
        { expr = true, replace_keycodes = false })
    map(modes.s, '<C-J>',
        [[luasnip#choice_active() ? '<cmd>lua require("luasnip").change_choice(1)<CR>' : '<C-J>']],
        { expr = true, replace_keycodes = false })
    map(modes.i, '<C-K>',
        [[luasnip#choice_active() ? '<cmd>lua require("luasnip").change_choice(-1)<CR>' : '<C-K>']],
        { expr = true, replace_keycodes = false })
    map(modes.s, '<C-K>',
        [[luasnip#choice_active() ? '<cmd>lua require("luasnip").change_choice(-1)<CR>' : '<C-K>']],
        { expr = true, replace_keycodes = false })
    -- Expand %% to the directory of the currently open file
    map(modes.c, '%%', [[<C-R>=expand('%:h') . '/'<CR>]])

    -- UNIMPAIRED --
    map(modes.n, '[b', vim.cmd.bprevious, { desc = 'go to previous buffer' })
    map(modes.n, '[q', vim.cmd.cprevious, { desc = 'go to previous quickfix' })
    map(modes.n, '[Q', vim.cmd.qfirst, { desc = 'go to first quickfix' })
    map(modes.n, ']b', vim.cmd.bprevious, { desc = 'go to next buffer' })
    map(modes.n, ']q', vim.cmd.cnext, { desc = 'go to next quickfix' })
    map(modes.n, ']Q', vim.cmd.qlast, { desc = 'go to last quickfix' })

    -- NAVIGATION --
    map(modes.n, '<leader><leader><leader>', function() require('harpoon.ui').toggle_quick_menu() end,
        { desc = 'open Harpoon quick list' })
    map(modes.n, '<leader><leader><CR>', function() require('util.alternate').open_alternate() end,
        { desc = 'open alternate here' })
    map(modes.n, '<leader><leader>1', function() require('harpoon.ui').nav_file(1) end,
        { desc = 'navigate to Harpoon file #1' })
    map(modes.n, '<leader><leader>2', function() require('harpoon.ui').nav_file(2) end,
        { desc = 'navigate to Harpoon file #2' })
    map(modes.n, '<leader><leader>3', function() require('harpoon.ui').nav_file(3) end,
        { desc = 'navigate to Harpoon file #3' })
    map(modes.n, '<leader><leader>4', function() require('harpoon.ui').nav_file(4) end,
        { desc = 'navigate to Harpoon file #4' })
    map(modes.n, '<leader><leader>5', function() require('harpoon.ui').nav_file(5) end,
        { desc = 'navigate to Harpoon file #5' })
    map(modes.n, '<leader><leader>h', function() require('util.alternate').open_split('left') end,
        { desc = 'open split left' })
    map(modes.n, '<leader><leader>j', function() require('util.alternate').open_split('down') end,
        { desc = 'open split below' })
    map(modes.n, '<leader><leader>k', function() require('util.alternate').open_split('up') end,
        { desc = 'open split above' })
    map(modes.n, '<leader><leader>l', function() require('util.alternate').open_split('right') end,
        { desc = 'open split right' })
    map(modes.n, '<leader><leader>m', function() require('harpoon.mark').add_file() end,
        { desc = 'add file to Harpoon list' })
    map(modes.n, '<leader><leader>H', function() require('util.alternate').open_alternate('left') end,
        { desc = 'open alternate file left' })
    map(modes.n, '<leader><leader>J', function() require('util.alternate').open_alternate('down') end,
        { desc = 'open alternate file down' })
    map(modes.n, '<leader><leader>K', function() require('util.alternate').open_alternate('up') end,
        { desc = 'open alternate file up' })
    map(modes.n, '<leader><leader>L', function() require('util.alternate').open_alternate('right') end,
        { desc = 'open alternate file right' })

    -- FOLLOW REFERENCES --
    map(modes.n, '<leader>]h', function() require('util.alternate').open_definition('left') end,
        { desc = 'follow reference left' })
    map(modes.n, '<leader>]j', function() require('util.alternate').open_definition('down') end,
        { desc = 'follow reference down' })
    map(modes.n, '<leader>]k', function() require('util.alternate').open_definition('up') end,
        { desc = 'follow reference up' })
    map(modes.n, '<leader>]l', function() require('util.alternate').open_definition('right') end,
        { desc = 'follow reference right' })

    -- TOGGLES --
    map(modes.n, '<leader>t2', function() require('util.indent').set_buf_indent(2, false, true) end,
        { desc = 'toggle indent: 2 spaces' })
    map(modes.n, '<leader>t4', function() require('util.indent').set_buf_indent(4, false, true) end,
        { desc = 'toggle indent: 4 spaces' })
    map(modes.n, '<leader>t8', function() require('util.indent').set_buf_indent(8, false, true) end,
        { desc = 'toggle indent: 8 spaces' })
    map(modes.n, '<leader>t<tab>', function() require('util.indent').set_buf_indent(4, true, true) end,
        { desc = 'toggle indent: tabs' })
    map(modes.n, '<leader>tf', function()
            vim.g.do_not_autoformat = not vim.g.do_not_autoformat
            if vim.g.do_not_autoformat then
                print('Autoformat off')
            else
                print('Autoformat on')
            end
        end,
        { desc = 'toggle autoformat (globally)' })
    map(modes.n, '<leader>tl', '<cmd>set list! list?<CR>', { desc = 'toggle visible spaces' })
    map(modes.n, '<leader>ts', '<cmd>exec "set scrolloff=" . (102 - &scrolloff)<CR>',
        { desc = 'toggle typewriter scroll mode' })
    map(modes.n, '<leader>tw', '<cmd>set wrap! wrap?<CR>', { desc = 'toggle wrap' })
    map(modes.n, '<leader>tz', vim.cmd.ZenMode, { desc = 'toggle zen mode' })

    -- BUFFER --
    map(modes.n, '<leader>bb', '<cmd>b#<CR>', { desc = 'go to previous buffer' })
    map(modes.n, '<leader>bd', vim.cmd.BufDel, { desc = 'delete current buffer' })
    map(modes.n, '<leader>bx', function() vim.cmd.bufdo('bdelete') end, { desc = 'close all buffers' })

    -- EXECUTING THINGS --
    map(modes.n, '<leader>xl', require('util.linkify').linkify, { desc = 'linkify', silent = true })
    map(modes.n, '<leader>xn', require('util.show-full-path').show_full_path,
        { desc = 'show full path', silent = true })
    map(modes.n, '<leader>xs', require('util.snippets').reload, { desc = 'reload snippets', silent = true })

    -- FINDING --
    map(modes.n, '<leader>fb', function() vim.cmd.Telescope('buffers', 'show_all_buffers=true') end,
        { desc = 'find buffers' })
    map(modes.n, '<leader>fd', function() vim.cmd.Telescope('diagnostics', 'bufnr=0') end,
        { desc = 'find diagnostics' })
    map(modes.n, '<leader>fD', function() vim.cmd.Telescope('diagnostics') end,
        { desc = 'find workspace diagnostics' })
    map(modes.n, '<leader>ff',
        function() vim.cmd.Telescope('find_files', 'find_command=rg,--ignore,--hidden,--files,--glob,!.git/*') end,
        { desc = 'find files' })
    map(modes.n, '<leader>fg',
        function() require('telescope.builtin').grep_string({ search = vim.fn.input('Grep ❯ ') }) end,
        { desc = 'grep in workspace' })
    map(modes.n, '<leader>fh', function() vim.cmd.Telescope('git_status') end, { desc = 'find modified files' })
    map(modes.n, '<leader>f?', function() vim.cmd.Telescope('help_tags') end, { desc = 'find help item' })
    map(modes.n, '<leader>fm', function() vim.cmd.Telescope('keymaps') end, { desc = 'find Vim mapping' })
    map(modes.n, '<leader>fn', vim.cmd.NvimTreeFindFileToggle, { desc = 'open file tree' })
    map(modes.n, '<leader>fu', vim.cmd.UndotreeToggle, { desc = 'open undo tree' })
    map(modes.n, '<leader>f*',
        function() require('telescope.builtin').grep_string({ search = vim.fn.expand('<cword>') }) end,
        { desc = 'grep current wordt in workspace' })
    map(modes.n, '<leader>f:', function() vim.cmd.Telescope('commands') end, { desc = 'find Vim command' })
    map(modes.n, '<leader>f<space>', function() vim.cmd.Telescope('resume') end, { desc = 'resume previous search' })

    -- GIT --
    map(modes.n, '<leader>hB',
        function() floaterm.floatermsend('tig blame +' .. vim.fn.line('.') .. ' ' .. vim.fn.expand('%')) end,
        { desc = 'git blame file' })
    map(modes.n, '<leader>hh',
        function() floaterm.floatermsend('tig ' .. vim.fn.expand('%')) end,
        { desc = 'show git file history' })

    -- MAKE-ING --
    map(modes.n, '<leader>m<CR>', vim.cmd.TestLast, { desc = 'run last test' })
    map(modes.n, '<leader>mt', vim.cmd.TestNearest, { desc = 'run nearest test' })
    map(modes.n, '<leader>mT', vim.cmd.TestFile, { desc = 'test current file' })

    -- REFACTORING --
    map(modes.n, '<leader>ri', function() require('refactoring').refactor('Inline Variable') end,
        { desc = 'refactor: inline variable' })
    map(modes.v, '<leader>rm', function() require('refactoring').refactor('Extract Function') end,
        { desc = 'refactor: extract method' })
    map(modes.v, '<leader>rv', function() require('refactoring').refactor('Extract Variable') end,
        { desc = 'refactor: extract variable' })
    map(modes.n, '<leader>rp', function() require('refactoring').debug.print_var({ normal = true }) end,
        { desc = 'refactor: extract variable' })
    map(modes.n, '<leader>r<', require('sibling-swap').swap_with_left, { desc = 'Swap sibling left' })
    map(modes.n, '<leader>r>', require('sibling-swap').swap_with_right, { desc = 'Swap sibling right' })

    -- WINDOW --
    map(modes.n, '<leader>w_', function() vim.cmd.wincmd('_') end, { desc = 'enlarge window' })
    map(modes.n, '<leader>w=', function() vim.cmd.wincmd('=') end, { desc = 'equalize windows' })
    map(modes.n, '<leader>w0', function() vim.cmd.wincmd('r') end, { desc = 'rotate windows' })
    map(modes.n, '<leader>wk', function() vim.cmd.wincmd('w') end, { desc = 'move into floating window' })
    map(modes.n, '<leader>ww', vim.cmd.SwapSplit, { desc = 'swap windows' })
    map(modes.n, '<leader>wz', require('util.toggle-zoom').toggle_zoom, { desc = 'toggle zoom mode' })
    map(modes.n, '<leader>wZ', vim.cmd.ZenMode, { desc = 'toggle zen mode' })

    -- TERMINAL --
    map(modes.i, '<C-CR>', '<Esc><cmd>FloatermToggle<CR>')
    map(modes.n, '<C-CR>', vim.cmd.FloatermToggle)
    map(modes.t, '<C-CR>', vim.cmd.FloatermHide)
    map(modes.t, '<S-Esc>', '<C-\\><C-N>')
    map(modes.t, '<C-H>', '<C-\\><C-N><C-W>h')
    map(modes.t, '<C-J>', '<C-\\><C-N><C-W>j')
    map(modes.t, '<C-K>', '<C-\\><C-N><C-W>k')
    map(modes.t, '<C-L>', '<C-\\><C-N><C-W>l')
    map(modes.t, '<C-\\>t', vim.cmd.FloatermToggle, { desc = 'toggle terminal' })
end

-- LSP MAPPINGS --
function This.setup_lsp_diagnostics_and_formatting(client, bufnr)
    -- UNIMPAIRED --
    map(modes.n, '[D', function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end,
        { buffer = bufnr, desc = 'go to previous error' })
    map(modes.n, ']D', function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end,
        { buffer = bufnr, desc = 'go to next error' })
    map(modes.n, '[d', function() vim.diagnostic.goto_prev() end,
        { buffer = bufnr, desc = 'go to previous diagnostic' })
    map(modes.n, ']d', function() vim.diagnostic.goto_next() end,
        { buffer = bufnr, desc = 'go to next diagnostic' })

    -- MAKE-ING --
    map(modes.n, '<leader>md', function() vim.cmd.Telescope('lsp_document_diagnostics') end,
        { buffer = bufnr, desc = 'show file diagnostics' })
    map(modes.n, '<leader>mD', function() vim.cmd.Telescope('lsp_workspace_diagnostics') end,
        { buffer = bufnr, desc = 'show workspace diagnostics' })

    -- SHOWING THINGS --
    map(modes.n, '<leader>sd', function() vim.diagnostic.open_float() end,
        { buffer = bufnr, desc = 'show diagnostic under cursor' })

    if client.server_capabilities.documentFormattingProvider then
        map(modes.n, '<leader>mf', function() vim.lsp.buf.format() end,
            { buffer = bufnr, desc = 'format current file' })
    end
end

function This.setup_lsp(client, bufnr)
    This.setup_lsp_diagnostics_and_formatting(client, bufnr)

    -- VARIOUS --
    map(modes.n, 'K', function() vim.lsp.buf.hover() end, { buffer = bufnr, silent = true })
    map(modes.i, '<C-Space>', function() vim.lsp.buf.signature_help() end, { buffer = bufnr, silent = true })

    -- FINDING --
    map(modes.n, '<leader>fi', function() vim.cmd.Telescope('lsp_implementations') end,
        { buffer = bufnr, desc = 'implementations' })
    map(modes.n, '<leader>fr', function() vim.cmd.Telescope('lsp_references') end,
        { buffer = bufnr, desc = 'references' })
    map(modes.n, '<leader>fs', function() vim.cmd.Telescope('lsp_document_symbols') end,
        { buffer = bufnr, desc = 'find current file symbols' })
    map(modes.n, '<leader>fS', function() vim.cmd.Telescope('lsp_workspace_symbols') end,
        { buffer = bufnr, desc = 'find workspace symbols' })

    -- GOING PLACES  --
    map(modes.n, '<leader>gd', vim.lsp.buf.declaration, { buffer = bufnr, desc = 'go to declaration' })
    map(modes.n, '<leader>gi', vim.lsp.buf.implementation, { buffer = bufnr, desc = 'go to implementation' })
    map(modes.n, '<leader>gt', vim.lsp.buf.type_definition, { buffer = bufnr, desc = 'go to type definition' })

    -- REFACTORING --
    map(modes.n, '<leader>r<CR>', vim.lsp.buf.code_action, { buffer = bufnr, desc = 'show code actions' })
    map(modes.v, '<leader>r<CR>', vim.lsp.buf.code_action, { buffer = bufnr, desc = 'show code actions' })
    map(modes.n, '<leader>rr', vim.lsp.buf.rename, { buffer = bufnr, desc = 'refactor: rename' })

    -- SHOWING THINGS --
    map(modes.n, '<leader>ss', vim.lsp.buf.signature_help, { buffer = bufnr, desc = 'show signature help' })
end

-- DAP MAPPINGS --
function This.setup_dap(bufnr)
    -- DEBUGGING --
    map(modes.n, '<leader>d<space>', require('dap').repl.toggle, { buffer = bufnr, desc = 'debug: toggle repl' })
    map(modes.n, '<leader>db', require('dap').toggle_breakpoint,
        { buffer = bufnr, desc = 'debug: toggle breakpoint' })
    map(modes.n, '<leader>dc', require('dap').continue, { buffer = bufnr, desc = 'debug: continue' })
    map(modes.n, '<leader>di', require('dap').step_into, { buffer = bufnr, desc = 'debug: step into' })
    map(modes.n, '<leader>dl', require('dap').run_last, { buffer = bufnr, desc = 'debug: run last' })
    map(modes.n, '<leader>do', require('dap').step_over, { buffer = bufnr, desc = 'debug: step over' })
    map(modes.n, '<leader>dx', require('dap').step_out, { buffer = bufnr, desc = 'debug: step out' })

    -- SHOWING THINGS --
    map(modes.n, '<leader>sv', require('dap.ui.widgets').hover, { buffer = bufnr, desc = 'debug: show value' })
    map(modes.v, '<leader>sv', require('dap.ui.widgets').hover, { buffer = bufnr, desc = 'debug: show value' })
end

-- COMMANDS --

function This.setup()
    define_mappings()
end

return This
