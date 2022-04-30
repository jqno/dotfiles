local This = {}

This.rounded_border = { border = 'rounded' }

local default_indent = 2

function This.setup()
    vim.opt.expandtab = true
    vim.opt.ignorecase = true
    vim.opt.joinspaces = false
    vim.opt.linebreak = true
    vim.opt.listchars = {
        tab = '჻ ',
        trail = '·',
        precedes = '←',
        extends = '→',
        nbsp = '·'
    }
    vim.opt.number = true
    vim.opt.relativenumber = true
    vim.opt.scrolloff = 3
    vim.opt.shiftround = true
    vim.opt.shiftwidth = default_indent
    vim.opt.shortmess = vim.opt.shortmess - 'F' + 'c'
    vim.opt.showmode = false
    vim.opt.sidescrolloff = 5
    vim.opt.signcolumn = 'yes'
    vim.opt.smartcase = true
    vim.opt.softtabstop = default_indent
    vim.opt.tabstop = default_indent
    vim.opt.termguicolors = true
    vim.opt.titlestring = '%t - nvim'
    vim.opt.title = true
    vim.opt.updatetime = 300
    vim.opt.wrap = false

    vim.g.tranquility_overrides = { invert_statusline = true }
    vim.cmd('colorscheme green-tranquility')

    require('vim-util').augroup('HighlightOnYank', 'TextYankPost', '*',
        function()
        vim.highlight.on_yank {
            higroup = 'IncSearch',
            timeout = 150,
            on_visual = true
        }
    end)

    vim.diagnostic.config({ float = This.rounded_border })
end

return This
