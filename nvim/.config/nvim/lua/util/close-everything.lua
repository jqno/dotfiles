local This = {}

function This.close_everything()
    vim.cmd.pclose()
    vim.cmd.cclose()
    vim.cmd.lclose()
    vim.cmd.NvimTreeClose()
    vim.cmd.FloatermHide()
    vim.cmd.UndotreeHide()
    vim.cmd.OutlineClose()

    require('dap').repl.close()
end

return This
