local This = {}

function This.floatermsend(cmd)
    if vim.fn['floaterm#buflist#curr']() == -1 then
        vim.cmd.FloatermNew('--silent')
    end
    vim.cmd.FloatermShow()
    vim.cmd.FloatermSend('clear')
    vim.cmd.FloatermSend(cmd)
end

return This
