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
    vim.opt.winborder = 'rounded'
    vim.opt.wrap = false

    local diag = require('util.icons')
    vim.diagnostic.config({
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
            source = true
        },
        update_in_insert = false
    })
end

return This
