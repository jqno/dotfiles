local This = {}

function This.send(cmd)
    vim.cmd.write() -- Just in case the auto-save doesn't catch it
    require('plugins.conform').autoformat()

    if vim.fn['floaterm#buflist#curr']() == -1 then
        vim.cmd.FloatermNew('--silent')
    end
    vim.cmd.FloatermShow()
    vim.cmd.FloatermSend('clear')
    vim.cmd.FloatermSend(cmd)
end

function This.toggle()
    require('plugins.conform').autoformat()
    vim.cmd.FloatermToggle()
end

return This
