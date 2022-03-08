This = {}

local fn = vim.fn
local exec = vim.api.nvim_exec

function This.close_everything()
    vim.api.nvim_command('pclose')
    vim.api.nvim_command('cclose')
    vim.api.nvim_command('NvimTreeClose')
    vim.api.nvim_command(
        'windo if &ft=="git" || &ft=="fugitiveblame" | q | endif')
    require('dap').repl.close()
end

function This.set_buf_indent(indent, show)
    if indent == nil then
        -- tab
        vim.bo.expandtab = false
        vim.bo.shiftwidth = 8
        vim.bo.softtabstop = 8
        vim.bo.tabstop = 8
        if show then
            print('Indentation level: tab')
        end
    else
        -- spaces
        vim.bo.expandtab = true
        vim.bo.shiftwidth = indent
        vim.bo.softtabstop = indent
        vim.bo.tabstop = indent
        if show then
            print('Indentation level: ' .. indent)
        end
    end
end

function This.toggle_movement(firstOp, thenOp)
    -- Inspired by http://ddrscott.github.io/blog/2016/vim-toggle-movement/
    local pos1 = fn.getpos('.')
    exec('normal! ' .. firstOp, false)
    if vim.deep_equal(pos1, fn.getpos('.')) then
        exec('normal! ' .. thenOp, false)
    end
end

function This.show_full_path()
    exec('echo "Full path: [" .. expand("%") .. "]"', false)
end

function This.toggle_nvimtree()
    local tree = require('nvim-tree')
    local view = require('nvim-tree.view')
    if view.is_visible() then
        view.close()
    elseif string.find(fn.expand('%:p'), 'Dropbox/notes') then
        tree.open(vim.env.HOME .. '/Dropbox/notes')
    else
        tree.open('.')
    end
end

function This.linkify()
    local url = fn.expand('<cWORD>')
    local shell_esc_url = fn.shellescape(url)
    local regex_esc_url = fn.escape(url, '/')

    local link = fn.system('linkify.py ' .. shell_esc_url)

    local chomped = fn.substitute(link, '\\n\\+$', '', '')
    local escaped = fn.substitute(chomped, '&', '\\\\&', '')
    local replaced = fn.substitute(fn.getline('.'), regex_esc_url, escaped, '')

    fn.setline('.', replaced)
end

return This
