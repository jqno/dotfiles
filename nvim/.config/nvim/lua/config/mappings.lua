local This = {}

local map = vim.keymap.set
local modes = require('util.modes')
local centered = require('util.centered').centered
local floaterm = require('plugins.floaterm')

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
    -- Switch yanking behaviour when pasting in visual mode
    map(modes.v, 'p', 'P', { noremap = true })
    map(modes.v, 'P', 'p', { noremap = true })
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
    -- Remove search highlights
    map(modes.n, '<Esc>', function() vim.cmd.nohlsearch() end)

    -- VARIOUS MAPPINGS --
    -- Comment lines
    map(modes.n, '\\\\', 'gcc', { remap = true })
    map(modes.v, '\\', 'gcgv', { remap = true })
    map(modes.n, '<C-/>', 'gcc', { remap = true })
    map(modes.v, '<C-/>', 'gcgv', { remap = true })

    -- Moving lines and blocks
    map(modes.n, '<M-S-j>', '<cmd>move .+1<CR>==')
    map(modes.n, '<M-S-k>', '<cmd>move .-2<CR>==')
    map(modes.v, '<M-S-j>', [[:move '>+1<CR>gv=gv]])
    map(modes.v, '<M-S-k>', [[:move '<-2<CR>gv=gv]])

    -- Easy window switching
    map(modes.n, '<C-h>', require('smart-splits').move_cursor_left)
    map(modes.n, '<C-j>', require('smart-splits').move_cursor_down)
    map(modes.n, '<C-k>', require('smart-splits').move_cursor_up)
    map(modes.n, '<C-l>', require('smart-splits').move_cursor_right)

    -- Easy window resizing
    map(modes.n, '<M-h>', require('smart-splits').resize_left)
    map(modes.n, '<M-j>', require('smart-splits').resize_down)
    map(modes.n, '<M-k>', require('smart-splits').resize_up)
    map(modes.n, '<M-l>', require('smart-splits').resize_right)

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
    map(modes.n, '[q', centered(vim.cmd.cprevious), { desc = 'go to previous quickfix' })
    map(modes.n, '[Q', centered(vim.cmd.qfirst), { desc = 'go to first quickfix' })
    map(modes.n, ']b', vim.cmd.bprevious, { desc = 'go to next buffer' })
    map(modes.n, ']q', centered(vim.cmd.cnext), { desc = 'go to next quickfix' })
    map(modes.n, ']Q', centered(vim.cmd.qlast), { desc = 'go to last quickfix' })
    map(modes.n, '[D', centered(function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end),
        { desc = 'go to previous error' })
    map(modes.n, ']D', centered(function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end),
        { desc = 'go to next error' })
    map(modes.n, '[d', centered(function() vim.diagnostic.goto_prev() end), { desc = 'go to previous diagnostic' })
    map(modes.n, ']d', centered(function() vim.diagnostic.goto_next() end), { desc = 'go to next diagnostic' })
    map(modes.n, '[<space>', '<cmd>Grapple cycle_backward<CR>', { desc = 'go to previous Grapple file' })
    map(modes.n, ']<space>', '<cmd>Grapple cycle_forward<CR>', { desc = 'go to next Grapple file' })

    -- NAVIGATION --
    map(modes.n, '<leader><leader><Space>', '<cmd>Grapple toggle_tags<CR>', { desc = 'open Grapple menu' })
    map(modes.n, '<leader><leader><BS>', function() require('util.alternate').open_alternate() end,
        { desc = 'open alternate here' })
    map(modes.n, '<leader><leader><CR>', floaterm.toggle, { desc = 'open terminal' })
    map(modes.n, '<leader><leader><Esc>', require('util.close-everything').close_everything, { desc = 'Close everything' })
    map(modes.n, '<leader><leader>1', '<cmd>Grapple select index=1<CR>', { desc = 'navigate to Grapple file #1' })
    map(modes.n, '<leader><leader>2', '<cmd>Grapple select index=2<CR>', { desc = 'navigate to Grapple file #2' })
    map(modes.n, '<leader><leader>3', '<cmd>Grapple select index=3<CR>', { desc = 'navigate to Grapple file #3' })
    map(modes.n, '<leader><leader>4', '<cmd>Grapple select index=4<CR>', { desc = 'navigate to Grapple file #4' })
    map(modes.n, '<leader><leader>5', '<cmd>Grapple select index=5<CR>', { desc = 'navigate to Grapple file #5' })
    map(modes.n, '<leader><leader>h', function() require('util.alternate').open_split('left') end,
        { desc = 'open split left' })
    map(modes.n, '<leader><leader>j', function() require('util.alternate').open_split('down') end,
        { desc = 'open split below' })
    map(modes.n, '<leader><leader>k', function() require('util.alternate').open_split('up') end,
        { desc = 'open split above' })
    map(modes.n, '<leader><leader>l', function() require('util.alternate').open_split('right') end,
        { desc = 'open split right' })
    map(modes.n, '<leader><leader>m', '<cmd>Grapple toggle<CR><cmd>echo "Added to Grapple list"<CR>',
        { desc = 'add file to Grapple list' })
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
    map(modes.n, '<leader>tc', vim.cmd.ColorizerToggle, { desc = 'toggle colorization' })
    map(modes.n, '<leader>td', require('util.diagnostics').toggle_all, { desc = 'toggle diagnostics' })
    map(modes.n, '<leader>ti', function()
            local is_enabled = vim.lsp.inlay_hint.is_enabled({})
            vim.lsp.inlay_hint.enable(not is_enabled)
        end,
        { desc = 'toggle inlay hints' })
    map(modes.n, '<leader>tf', function()
            local bufnr = vim.fn.bufnr()
            vim.b[bufnr].do_autoformat = not vim.b[bufnr].do_autoformat
            if vim.b[bufnr].do_autoformat then
                print('Autoformat (buffer) on')
            else
                print('Autoformat (buffer) off')
            end
        end,
        { desc = 'toggle autoformat (buffer)' })
    map(modes.n, '<leader>tF', function()
            vim.g.do_autoformat = not vim.g.do_autoformat
            if vim.g.do_autoformat then
                print('Autoformat (global) on')
            else
                print('Autoformat (global) off')
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
    map(modes.n, '<leader>bx', function() vim.cmd('%bd|e#|bd#') end, { desc = 'close all buffers except current' })
    map(modes.n, '<leader>bX', function() vim.cmd.bufdo('bdelete') end, { desc = 'close all buffers' })

    -- EXECUTING THINGS --
    map(modes.n, '<leader>xb', ':%!base64 -d<CR>', { desc = 'base64 decode', silent = true })
    map(modes.n, '<leader>xB', ':%!base64<CR>', { desc = 'base64 encode', silent = true })
    map(modes.v, '<leader>xb', ':!base64 -d<CR>', { desc = 'base64 decode', silent = true })
    map(modes.v, '<leader>xB', ':!base64<CR>', { desc = 'base64 encode', silent = true })
    map(modes.n, '<leader>xe', [[:%s/'/'\r/g<CR>]], { desc = 'expand edifact', silent = true })
    map(modes.n, '<leader>xE', [[:%s/\n//g<CR>0]], { desc = 'implode edifact', silent = true })
    map(modes.v, '<leader>xe', [[:s/'/'\r/g<CR>]], { desc = 'expand edifact', silent = true })
    map(modes.v, '<leader>xE', [[:s/\n//g<CR>0]], { desc = 'implode edifact', silent = true })
    map(modes.n, '<leader>xl', require('util.linkify').linkify, { desc = 'linkify', silent = true })
    map(modes.n, '<leader>xn', require('util.show-full-path').show_full_path,
        { desc = 'show full path', silent = true })
    map(modes.n, '<leader>xo', '<cmd>OutputPanel<CR>', { desc = 'shows logging for LSP server', silent = true })
    map(modes.n, '<leader>xs', require('plugins.luasnip').reload, { desc = 'reload snippets', silent = true })
    map(modes.n, '<leader>xu', 'a<C-R>=v:lua.require("util.uuid").generate()<CR><Esc>', { desc = 'insert a random uuid' })

    -- FINDING --
    map(modes.n, '<leader>fb', function() vim.cmd.Telescope('buffers', 'show_all_buffers=true') end,
        { desc = 'find buffers' })
    map(modes.n, '<leader>fd', function() vim.cmd.Telescope('diagnostics', 'bufnr=0') end,
        { desc = 'find diagnostics' })
    map(modes.n, '<leader>fD', function() vim.cmd.Telescope('diagnostics') end,
        { desc = 'find workspace diagnostics' })
    map(modes.n, '<leader>ff', function() vim.cmd.Telescope('smart_open', 'cwd_only=true') end,
        { desc = 'smart find files' })
    map(modes.n, '<leader>fF',
        function() vim.cmd.Telescope('find_files', 'find_command=rg,--ignore,--hidden,--files,--glob,!.git/*') end,
        { desc = 'find files' })
    map(modes.n, '<leader>fg',
        function()
            local s = vim.fn.input({ prompt = 'Grep ❯ ', cancelreturn = '' })
            if s ~= '' then
                require('telescope.builtin').grep_string({ search = s })
            end
        end,
        { desc = 'grep in workspace' })
    map(modes.n, '<leader>fh', function() vim.cmd.Telescope('git_status') end, { desc = 'find modified files' })
    map(modes.n, '<leader>f?', function() vim.cmd.Telescope('help_tags') end, { desc = 'find help item' })
    map(modes.n, '<leader>fm', function() vim.cmd.Telescope('keymaps') end, { desc = 'find Vim mapping' })
    map(modes.n, '<leader>fn', vim.cmd.NvimTreeFindFileToggle, { desc = 'open file tree' })
    map(modes.n, '<leader>fo', vim.cmd.Outline, { desc = 'open outline' })
    map(modes.n, '<leader>ft', '<cmd>TodoTelescope<CR>', { desc = 'find TODO comments' })
    map(modes.n, '<leader>fu', vim.cmd.UndotreeToggle, { desc = 'open undo tree' })
    map(modes.n, '<leader>f*',
        function() require('telescope.builtin').grep_string({ search = vim.fn.expand('<cword>') }) end,
        { desc = 'grep current wordt in workspace' })
    map(modes.n, '<leader>f:', function() vim.cmd.Telescope('commands') end, { desc = 'find Vim command' })
    map(modes.n, '<leader>f<space>', function() vim.cmd.Telescope('resume') end, { desc = 'resume previous search' })

    -- GIT --
    map(modes.n, '<leader>hB',
        function() floaterm.send('tig blame +' .. vim.fn.line('.') .. ' ' .. vim.fn.expand('%')) end,
        { desc = 'git blame file' })
    map(modes.n, '<leader>hh',
        function() floaterm.send('tig ' .. vim.fn.expand('%')) end,
        { desc = 'show git file history' })

    -- MAKE-ING --
    map(modes.n, '<leader>mm', require('util.job-runner').set_job, { desc = 'set current job' })
    map(modes.n, '<leader>m<CR>', require('util.job-runner').run_job, { desc = 'run last test or current job' })
    map(modes.n, '<leader>mt', vim.cmd.TestNearest, { desc = 'run nearest test' })
    map(modes.n, '<leader>mT', vim.cmd.TestFile, { desc = 'test current file' })
    map(modes.n, '<leader>mf', require('util.format').save_and_format, { desc = 'format current file' })

    -- REFACTORING --
    map(modes.n, '<leader>r<', require('sibling-swap').swap_with_left, { desc = 'Swap sibling left' })
    map(modes.n, '<leader>r>', require('sibling-swap').swap_with_right, { desc = 'Swap sibling right' })

    -- SHOWING THINGS, SESSIONS --
    map(modes.n, '<leader>sd', function() vim.diagnostic.open_float() end, { desc = 'show diagnostic under cursor' })
    map(modes.n, '<leader>st', '<cmd>TodoQuickFix<CR>', { desc = 'show TODO comments in quickfix' })
    map(modes.n, '<leader>sw', '<cmd>mksession!<CR><cmd>echo "Session saved"<CR>', { desc = 'save the current session' })
    map(modes.n, '<leader>se', '<cmd>so Session.vim<CR>', { desc = 'load the saved session' })

    -- WINDOW --
    map(modes.n, '<leader>w_', function() vim.cmd.wincmd('_') end, { desc = 'enlarge window' })
    map(modes.n, '<leader>w=', function() vim.cmd.wincmd('=') end, { desc = 'equalize windows' })
    map(modes.n, '<leader>w0', function() vim.cmd.wincmd('r') end, { desc = 'rotate windows' })
    map(modes.n, '<leader>wk', function() vim.cmd.wincmd('w') end, { desc = 'move into floating window' })
    map(modes.n, '<leader>ww', function() vim.cmd.WinShift('swap') end, { desc = 'swap windows' })
    map(modes.n, '<leader>wz', require('util.toggle-zoom').toggle_zoom, { desc = 'toggle zoom mode' })
    map(modes.n, '<leader>wZ', vim.cmd.ZenMode, { desc = 'toggle zen mode' })

    -- TERMINAL --
    map(modes.i, '<C-CR>', [[<Esc><cmd>lua require('plugins.floaterm').toggle()<CR>]])
    map(modes.n, '<C-CR>', floaterm.toggle)
    map(modes.t, '<C-CR>', vim.cmd.FloatermHide)
    map(modes.t, '<C-]>', vim.cmd.FloatermHide)
    map(modes.t, '<S-Esc>', '<C-\\><C-N>')
    map(modes.t, '<C-H>', '<C-\\><C-N><C-W>h')
    map(modes.t, '<C-J>', '<C-\\><C-N><C-W>j')
    map(modes.t, '<C-K>', '<C-\\><C-N><C-W>k')
    map(modes.t, '<C-L>', '<C-\\><C-N><C-W>l')
    map(modes.t, '<C-\\>t', vim.cmd.FloatermToggle, { desc = 'toggle terminal' })
end

function This.setup_lsp(bufnr)
    -- VARIOUS --
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

    -- LSP/CODELENS --
    map(modes.n, '<leader>l<SPACE>', function() vim.lsp.codelens.refresh({ bufnr = 0 }) end,
        { buffer = bufnr, desc = 'refresh codelens' })
    map(modes.n, '<leader>l<BS>', function() vim.lsp.codelens.clear(nil, 0) end,
        { buffer = bufnr, desc = 'clear codelens' })
    map(modes.n, '<leader>l<CR>', vim.lsp.codelens.run, { desc = 'run codelens' })
end

function This.setup()
    define_mappings()
end

return This
