local This = {}

function This.send(cmd)
    vim.cmd.write() -- Just in case the auto-save doesn't catch it
    require('plugins.conform').autoformat()

    vim.cmd.TermExec("cmd='clear'")
    vim.cmd.TermExec("cmd='" .. cmd .. "'")
end

function This.toggle()
    require('plugins.conform').autoformat()
    vim.cmd.ToggleTerm()
end

return This
