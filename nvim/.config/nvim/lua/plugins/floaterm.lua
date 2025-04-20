local function send(cmd)
    vim.cmd.write() -- Just in case the auto-save doesn't catch it
    require('plugins.conform').autoformat()

    if vim.fn['floaterm#buflist#curr']() == -1 then
        vim.cmd.FloatermNew('--silent')
    end
    vim.cmd.FloatermShow()
    vim.cmd.FloatermSend('clear')
    vim.cmd.FloatermSend(cmd)
end

local function toggle()
    require('plugins.conform').autoformat()
    vim.cmd.FloatermToggle()
end

return {
    'voldikss/vim-floaterm',
    event = 'UIEnter',

    init = function()
        vim.g.floaterm_title = 'Terminal'
        vim.g.floaterm_wintype = 'split'
        vim.g.floaterm_height = 0.4
        vim.g.floaterm_width = 0.4
    end,

    send = send,
    toggle = toggle
}
