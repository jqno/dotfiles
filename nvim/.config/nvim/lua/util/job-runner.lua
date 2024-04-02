local This = {}

local floaterm = require('plugins.floaterm')
local current_job = nil

function This.set_job()
    local input = vim.fn.input('What job do you want to run? (empty to reset) ')
    if input == nil or input == '' then
        print('Job cleared; will default to last test')
        current_job = nil
    else
        print('Job set to: ' .. input)
        current_job = input
    end
end

function This.run_job()
    if current_job == nil then
        vim.cmd.TestLast()
    else
        floaterm.send(current_job)
    end
end

return This
