local This = {}

local default_indent = 2

function This.setup()
    -- Disable netrw for a better nvim-tree experience
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    vim.g.mapleader = ' '

    vim.opt.cursorline = true
    vim.opt.cursorlineopt = 'number'
    vim.opt.expandtab = true
    vim.opt.exrc = true
    vim.opt.ignorecase = true
    vim.opt.joinspaces = false
    vim.opt.linebreak = true
    vim.opt.diffopt = vim.opt.diffopt + 'linematch:60'
    vim.opt.list = true
    vim.opt.listchars = {
        tab = '჻ ',
        trail = '·',
        precedes = '←',
        extends = '→',
        nbsp = '·'
    }
    vim.opt.number = true
    vim.opt.scrolloff = 3
    vim.opt.shiftround = true
    vim.opt.shiftwidth = default_indent
    vim.opt.shortmess = vim.opt.shortmess - 'F' + 'c'
    vim.opt.showmode = false
    vim.opt.sidescrolloff = 5
    vim.opt.signcolumn = 'yes'
    vim.opt.smartcase = true
    vim.opt.softtabstop = default_indent
    vim.opt.splitbelow = true
    vim.opt.splitright = true
    vim.opt.tabstop = default_indent
    vim.opt.titlestring = '%t - nvim'
    vim.opt.title = true
    vim.opt.undodir = vim.env.HOME .. '/.vim/undodir'
    vim.opt.undofile = true
    vim.opt.updatetime = 300
    vim.opt.wrap = false

    local leadmultispace = vim.api.nvim_create_augroup('lead_multi_space', { clear = true })
    vim.api.nvim_create_autocmd('OptionSet', {
        group = leadmultispace,
        pattern = { 'listchars', 'tabstop', 'filetype' },
        callback = require('util.indent').set_leadmultispace
    })
    vim.api.nvim_create_autocmd('VimEnter', {
        group = leadmultispace,
        callback = require('util.indent').set_leadmultispace,
        once = true
    })

    vim.api.nvim_create_autocmd('TextYankPost', {
        group = vim.api.nvim_create_augroup('highlight_on_yank', { clear = true }),
        pattern = '*',
        callback = function()
            vim.highlight.on_yank {
                higroup = 'IncSearch',
                timeout = 150,
                on_visual = true
            }
        end
    })

    local diag = require('util.icons')
    vim.diagnostic.config({
        virtual_text = false,
        underline = true,
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = diag.error,
                [vim.diagnostic.severity.WARN] = diag.warn,
                [vim.diagnostic.severity.INFO] = diag.info,
                [vim.diagnostic.severity.HINT] = diag.hint,
            }
        },
        float = {
            border = 'rounded',
            source = true
        },
        update_in_insert = false
    })
end

return This
