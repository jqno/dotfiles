local This = {}

function This.floatermsend(cmd)
    require('util.format').format()

    if vim.fn['floaterm#buflist#curr']() == -1 then
        vim.cmd.FloatermNew('--silent')
    end
    vim.cmd.FloatermShow()
    vim.cmd.FloatermSend('clear')
    vim.cmd.FloatermSend(cmd)
end

function This.floatermtoggle()
    require('util.format').format()
    vim.cmd.FloatermToggle()
end

return This
