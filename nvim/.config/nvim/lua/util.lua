This = {}

local fn = vim.fn
local exec = vim.api.nvim_exec

function This.close_everything()
    vim.cmd('pclose')
    vim.cmd('cclose')
    vim.cmd('lclose')
    vim.cmd('NvimTreeClose')
    vim.cmd('FloatermHide')
    vim.cmd('TroubleClose')
    require('dap').repl.close()

    vim.cmd('windo if &ft=="git" || &ft=="fugitiveblame" | q | endif')
    vim.cmd('windo if expand("%:t")=~#"dap-terminal" && &ft=="" | q | endif')
end

function This.set_buf_indent(indent, tab, show)
    vim.bo.expandtab = not tab
    vim.bo.shiftwidth = indent
    vim.bo.softtabstop = indent
    vim.bo.tabstop = indent
    if show then
        print('Indentation level: ' .. indent .. '; with tabs: ' .. tostring(tab))
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
    print('Full path: [' .. fn.expand('%') .. ']')
end

function This.floatermsend(cmd)
    if fn['floaterm#buflist#curr']() == -1 then
        vim.cmd('FloatermNew --silent')
    end
    vim.cmd('FloatermShow')
    vim.cmd('FloatermSend clear')
    vim.cmd('FloatermSend ' .. cmd)
end

local split_direction = {
    left  = {'wincmd h', 'vsplit | wincmd h'},
    down  = {'wincmd j', 'split'},
    up    = {'wincmd k', 'split | wincmd k'},
    right = {'wincmd l', 'vsplit'}
}

local function find_alternate()
    local curr = vim.fn.expand('%')
    if vim.bo.filetype == 'java' then
        if curr:find('src/main/java') then
            return curr:gsub('src/main/java', 'src/test/java'):gsub('%.java', 'Test.java')
        elseif curr:find('src/test/java') then
            return curr:gsub('src/test/java', 'src/main/java'):gsub('Test%.java', '.java')
        end
    end
    return nil
end

function This.open_alternate(direction)
    local alternate = find_alternate()
    if direction ~= nil then
        local win_before = vim.api.nvim_get_current_win()
        print(split_direction[direction][1])
        vim.cmd(split_direction[direction][1])
        local win_after = vim.api.nvim_get_current_win()
        if win_before == win_after then
            vim.cmd(split_direction[direction][2])
        end
    end
    if alternate ~= nil then
        vim.cmd('e ' .. alternate)
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
