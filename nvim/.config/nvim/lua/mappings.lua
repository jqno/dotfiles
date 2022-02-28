local This = {}

local map = require('vim-util').map
local wk = require('which-key').register

This.modes = {i = 'i', n = 'n', v = 'v', c = 'c', s = 's', t = 't'}

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
        [[v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj']],
        {expr = true})
    map(This.modes.n, 'k',
        [[v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk']],
        {expr = true})
    map(This.modes.v, 'j',
        [[v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj']],
        {expr = true})
    map(This.modes.v, 'k',
        [[v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk']],
        {expr = true})
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
        '<cmd>lua require("util").toggle_movement("^", "0")<CR>')
    map(This.modes.n, ';',
        '<cmd>lua require("util").toggle_movement(";", "0;")<CR>')
    map(This.modes.n, ',',
        '<cmd>lua require("util").toggle_movement(",", "$,")<CR>')
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
    map(This.modes.n, '\\\\', '<Plug>CommentaryLine', {noremap = false})
    map(This.modes.v, '\\', '<Plug>Commentary', {noremap = false})
    -- Moving lines and blocks
    map(This.modes.n, '<M-j>', '<cmd>move .+1<CR>==')
    map(This.modes.n, '<M-k>', '<cmd>move .-2<CR>==')
    map(This.modes.v, '<M-j>', [[:move '>+1<CR>gv=gv]])
    map(This.modes.v, '<M-k>', [[:move '<-2<CR>gv=gv]])

    -- Open Wiki --
    map(This.modes.n, '<F12>', '<cmd>WikiIndex<CR>')
    -- Snippets and jumps --
    map(This.modes.i, '<C-L>',
        [[luasnip#expand_or_jumpable() ? '<cmd>lua require("luasnip").expand_or_jump()<CR>' : JqnoAutocloseSmartJump()]],
        {expr = true})
    map(This.modes.s, '<C-L>',
        [[luasnip#expand_or_jumpable() ? '<cmd>lua require("luasnip").expand_or_jump()<CR>' : '<C-L>']],
        {expr = true})
    map(This.modes.i, '<C-J>',
        [[luasnip#choice_active() ? '<cmd>lua require("luasnip").change_choice(1)<CR>' : '<C-J>']],
        {expr = true})
    map(This.modes.s, '<C-J>',
        [[luasnip#choice_active() ? '<cmd>lua require("luasnip").change_choice(1)<CR>' : '<C-J>']],
        {expr = true})
    map(This.modes.i, '<C-K>',
        [[luasnip#choice_active() ? '<cmd>lua require("luasnip").change_choice(-1)<CR>' : '<C-J>']],
        {expr = true})
    map(This.modes.s, '<C-K>',
        [[luasnip#choice_active() ? '<cmd>lua require("luasnip").change_choice(-1)<CR>' : '<C-J>']],
        {expr = true})
    -- Expand %% to the directory of the currently open file
    map(This.modes.c, '%%', [[<C-R>=expand('%:h') . '/'<CR>]])

    wk({
        -- UNIMPAIRED --
        ['['] = {
            name = 'previous',
            ['['] = 'function',
            b = {'<cmd>bprevious<CR>', 'buffer'},
            g = 'git hunk',
            q = {'<cmd>cprevious<CR>', 'quickfix'},
            Q = {'<cmd>qfirst<CR>', 'quickfix first'}
        },
        [']'] = {
            name = 'next',
            [']'] = 'function',
            b = {'<cmd>bnext<CR>', 'buffer'},
            g = 'git hunk',
            Q = {'<cmd>clast<CR>', 'quickfix last'},
            q = {'<cmd>cnext<CR>', 'quickfix'}
        },
        -- RAW LEADER --
        ['<leader>'] = {
            ['<esc>'] = {
                '<cmd>lua require("util").close_everything()<CR>',
                'close everything',
                silent = true
            },
            -- defined elsewhere
            ['<C-D>'] = 'scroll down',
            ['<C-U>'] = 'scroll up'
        },
        -- HARPOON --
        ['<leader><leader>'] = {
            name = 'harpoon',
            ['<CR>'] = {
                '<cmd>echo "Added to mark list"<CR><bar><cmd>lua require("harpoon.mark").add_file()<CR>',
                'add file to list'
            },
            ['<leader>'] = {
                '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>',
                'open quick menu'
            },
            ['1'] = {
                '<cmd>lua require("harpoon.ui").nav_file(1)<CR>',
                'navigate to file 1'
            },
            ['2'] = {
                '<cmd>lua require("harpoon.ui").nav_file(2)<CR>',
                'navigate to file 2'
            },
            ['3'] = {
                '<cmd>lua require("harpoon.ui").nav_file(3)<CR>',
                'navigate to file 3'
            },
            ['4'] = {
                '<cmd>lua require("harpoon.ui").nav_file(4)<CR>',
                'navigate to file 4'
            }
        },
        -- TOGGLES --
        ['<leader>t'] = {
            name = 'toggles',
            ['2'] = {
                '<cmd>lua require("util").set_buf_indent(2, true)<CR>',
                'indent 2'
            },
            ['4'] = {
                '<cmd>lua require("util").set_buf_indent(4, true)<CR>',
                'indent 4'
            },
            ['8'] = {
                '<cmd>lua require("util").set_buf_indent(8, true)<CR>',
                'indent 8'
            },
            ['<tab>'] = {
                '<cmd>lua require("util").set_buf_indent(nil, true)<CR>',
                'indent tab'
            },
            l = {'<cmd>set list! list?<CR>', 'list'},
            t = {'<cmd>FloatermToggle<CR>', 'terminal'},
            s = {
                '<cmd>exec "set scrolloff=" . (102 - &scrolloff)<CR>',
                'typewriter scroll mode'
            },
            w = {'<cmd>set wrap! wrap?<CR>', 'wrap'},
            z = {'<cmd>ZenMode<CR>', 'zen mode'}
        },
        -- BUFFER --
        ['<leader>b'] = {
            name = 'buffer',
            b = {'<cmd>b#<CR>', 'previous'},
            d = {'<cmd>bd<CR>', 'delete'},
            ['<Backspace>'] = {'<cmd>bufdo bdelete<CR>', 'close all'}
        },
        ['<leader>d'] = {name = 'debug'},
        -- EXECUTING THINGS --
        ['<leader>x'] = {
            name = 'execute',
            l = {
                '<cmd>lua require("util").linkify()<CR>',
                'linkify',
                silent = true
            },
            n = {
                '<cmd>lua require("util").show_full_path()<CR>',
                'show full path',
                silent = true
            }
        },
        -- FINDING --
        ['<leader>f'] = {
            name = 'file',
            b = {'<cmd>Telescope buffers show_all_buffers=true<CR>', 'buffers'},
            f = {
                '<cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files,--glob,!.git/*<CR>',
                'files'
            },
            h = {'<cmd>Telescope help_tags<CR>', 'help'},
            i = {'<cmd>Telescope treesitter<CR>', 'identifiers'},
            n = {'<cmd>NvimTreeToggle<CR>', 'tree'},
            N = {'<cmd>NvimTreeFindFile<CR>', 'tree (follow)'},
            g = {
                '<cmd>lua require("telescope.builtin").grep_string({ search = vim.fn.input("Grep ❯ ") })<CR>',
                'grep'
            },
            q = {
                '<cmd>lua require("telescope.builtin").grep_string({ cwd = "~/Dropbox/notes", search = vim.fn.input("Wiki ❯ ") })<CR>',
                'wiki'
            },
            ['*'] = {
                '<cmd>lua require("telescope.builtin").grep_string({ search = vim.fn.expand("<cword>") })<CR>',
                'grep current'
            },
            [':'] = {'<cmd>Telescope commands<CR>', 'commands'}
        },
        -- GOING PLACES  --
        ['<leader>g'] = {name = 'go'},
        -- GIT --
        ['<leader>G'] = {
            name = 'Git',
            B = {'<cmd>Git blame<CR>', 'blame file'},
            h = {'<cmd>0Gclog<CR>', 'show file history'},
            -- following bindings come from GitSigns plugin
            b = 'blame line',
            p = 'preview hunk',
            R = 'reset buffer',
            r = 'reset hunk',
            s = 'stage hunk',
            u = 'undo stage hunk'
        },
        -- MAKE-ING --
        ['<leader>m'] = {
            name = 'make',
            ['<CR>'] = {'<cmd>TestNearest<CR>', 'test nearest'},
            t = {'<cmd>TestFile<CR>', 'test file'}
        },
        -- REFACTORING --
        ['<leader>r'] = {
            name = 'refactor',
            ['>'] = 'swap next',
            ['<'] = 'swap prev'
        },
        -- SHOWING THINGS --
        ['<leader>s'] = {name = 'show', c = 'peek class', f = 'peek function'},
        -- WIKI --
        ['<leader>q'] = {name = 'wiki', q = {'<cmd>WikiIndex<CR>', 'index'}},
        -- WINDOW --
        ['<leader>w'] = {
            name = 'window',
            ['_'] = {'<cmd>wincmd _<CR>', 'enlarge window'},
            ['='] = {'<cmd>wincmd =<CR>', 'equalize'},
            ['0'] = {'<cmd>wincmd r<CR>', 'rotate'},
            k = {'<C-w>w', 'move into floating window'}
        }
    })

    map(This.modes.t, '<C-\\><Esc>', '<C-\\><C-N>')
    wk({
        -- TERMINAL --
        ['<c-\\>'] = {
            name = 'terminal',
            t = {'<cmd>FloatermToggle<CR>', 'toggle'}
        }

    }, {mode = This.modes.t})
end

-- LSP MAPPINGS --
function This.setup_lsp_diagnostics_and_formatting(client, bufnr)
    wk({
        -- UNIMPAIRED --
        ['['] = {
            d = {
                '<cmd>lua vim.diagnostic.goto_prev({source="always"})<CR>',
                'diagnostic'
            }
        },
        [']'] = {
            d = {
                '<cmd>lua vim.diagnostic.goto_next({source="always"})<CR>',
                'diagnostic'
            }
        },
        -- MAKE-ING --
        ['<leader>m'] = {
            d = {
                '<cmd>Telescope lsp_document_diagnostics<CR>',
                'show diagnostics'
            },
            D = {
                '<cmd>Telescope lsp_workspace_diagnostics<CR>',
                'show ALL diagnostics'
            }
        },
        -- SHOWING THINGS --
        ['<leader>s'] = {
            d = {
                '<cmd>lua vim.diagnostic.open_float(nil, {source="always"})<CR>',
                'diagnostics'
            }
        }
    }, {buffer = bufnr})

    if client.resolved_capabilities.document_formatting then
        wk({
            ['<leader>m'] = {
                f = {'<cmd>lua vim.lsp.buf.formatting()<CR>', 'format'}
            }
        }, {buffer = bufnr})
    elseif client.resolved_capabilities.document_range_formatting then
        wk({
            ['<leader>m'] = {
                f = {'<cmd>lua vim.lsp.buf.range_formatting()<CR>', 'format'}
            }
        }, {buffer = bufnr, mode = This.modes.v})
    end
end

function This.setup_lsp(client, bufnr)
    local function buf_map(mode, lhs, rhs, opts)
        require('vim-util').buf_map(bufnr, mode, lhs, rhs, opts)
    end

    This.setup_lsp_diagnostics_and_formatting(client, bufnr)

    -- VARIOUS --
    buf_map(This.modes.n, 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
    buf_map(This.modes.i, '<C-Space>',
            '<cmd>lua vim.lsp.buf.signature_help()<CR>')

    wk({
        -- FINDING --
        ['<leader>f'] = {
            s = {'<cmd>Telescope lsp_document_symbols<CR>', 'document symbols'},
            S = {
                '<cmd>Telescope lsp_workspace_symbols<CR>', 'workspace symbols'
            },
            r = {'<cmd>Telescope lsp_references<CR>', 'references'}
        },
        -- GOING PLACES  --
        ['<leader>g'] = {
            [']'] = {'<cmd>lua vim.lsp.buf.definition()<CR>', 'definition'},
            d = {'<cmd>lua vim.lsp.buf.declaration()<CR>', 'declaration'},
            i = {'<cmd>lua vim.lsp.buf.implementation()<CR>', 'implementation'},
            t = {
                '<cmd>lua vim.lsp.buf.type_definition()<CR>', 'type definition'
            }
        },
        -- REFACTORING --
        ['<leader>r'] = {
            ['<CR>'] = {'<cmd>Telescope lsp_code_actions<CR>', 'code actions'},
            r = {'<cmd>lua vim.lsp.buf.rename()<CR>', 'rename'}
        },
        -- SHOWING THINGS --
        ['<leader>s'] = {
            s = {'<cmd>lua vim.lsp.buf.signature_help()<CR>', 'signature help'}
        }
    }, {buffer = bufnr})

    -- VISUAL MODE --
    wk({
        -- REFACTORING --
        ['<leader>r'] = {
            name = 'refactor',
            ['<CR>'] = {
                '<cmd>Telescope lsp_range_code_actions<CR>', 'code actions'
            }
        }
    }, {buffer = bufnr, mode = This.modes.v})
end

-- DAP MAPPINGS --
function This.setup_dap(bufnr)
    wk({
        -- DEBUGGING --
        ['<leader>d'] = {
            ['<space>'] = {
                '<cmd>lua require("dap").repl.toggle()<CR>', 'toggle repl'
            },
            b = {
                '<cmd>lua require("dap").toggle_breakpoint()<CR>', 'breakpoint'
            },
            c = {'<cmd>lua require("dap").continue()<CR>', 'continue'},
            i = {'<cmd>lua require("dap").step_into()<CR>', 'step into'},
            l = {'<cmd>lua require("dap").run_last()<CR>', 'run last'},
            o = {'<cmd>lua require("dap").step_over()<CR>', 'step over'},
            x = {'<cmd>lua require("dap").step_out()<CR>', 'step out'}
        },
        -- SHOWING THINGS --
        ['<leader>s'] = {
            v = {
                '<cmd>lua require("dap.ui.variables").hover()<CR>',
                'debug value'
            }
        }
    }, {buffer = bufnr})

    -- VISUAL --
    wk({
        ['<leader>s'] = {
            name = 'show',
            v = {
                '<cmd>lua require("dap.ui.variables").visual_hover()<CR>',
                'debug value'
            }
        }
    }, {buffer = bufnr, mode = This.modes.v})
end

function This.setup_wikivim()
    map(This.modes.n, '<CR>', '<Plug>(wiki-link-follow)', {noremap = false})
    map(This.modes.n, '<Tab>', '<Plug>(wiki-link-next)', {noremap = false})
    map(This.modes.n, '<S-Tab>', '<Plug>(wiki-link-prev)', {noremap = false})
    map(This.modes.n, '<BS>', '<Plug>(wiki-link-return)', {noremap = false})
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
