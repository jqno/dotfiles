local This = {}

local default_indent = 2

function This.setup()
    vim.g.mapleader = ' '

    vim.opt.expandtab = true
    vim.opt.exrc = true
    -- vim.opt.formatoptions:remove('o')
    vim.opt.ignorecase = true
    vim.opt.joinspaces = false
    vim.opt.linebreak = true
    vim.opt.list = true
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
    vim.opt.splitbelow = true
    vim.opt.splitright = true
    vim.opt.tabstop = default_indent
    vim.opt.termguicolors = true
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

    vim.api.nvim_create_autocmd({ 'BufWinEnter', 'BufReadPost' }, {
        -- Must do this in an autocmd because Neovim's built-in ftplugins often add it back
        group = vim.api.nvim_create_augroup('RemoveOFromFormatoptions', { clear = true }),
        pattern = '*',
        callback = function()
            vim.opt_local.formatoptions:remove('o')
        end,
    })

    vim.diagnostic.config({
        virtual_text = false,
        underline = true,
        signs = true,
        float = {
            border = 'rounded',
            source = true
        }
    })
    local diag = require('util.icons')
    vim.fn.sign_define('DiagnosticSignError', { text = diag.error, texthl = 'DiagnosticSignError' })
    vim.fn.sign_define('DiagnosticSignWarn', { text = diag.warn, texthl = 'DiagnosticSignWarn' })
    vim.fn.sign_define('DiagnosticSignInfo', { text = diag.info, texthl = 'DiagnosticSignInfo' })
    vim.fn.sign_define('DiagnosticSignHint', { text = diag.hint, texthl = 'DiagnosticSignHint' })
end

return This
