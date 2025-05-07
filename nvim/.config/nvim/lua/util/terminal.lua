local This = {}

This.direction = 'float'

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

function This.redirect(toggle_twice)
    if This.direction == 'float' then
        This.direction = require('util.screen-orientation').get_layout()
    else
        This.direction = 'float'
    end

    if toggle_twice then
        vim.cmd.ToggleTerm()
    end
    vim.cmd.ToggleTerm('direction=' .. This.direction)
end

return This
