local This = {}

function This.close_everything()
    vim.cmd.pclose()
    vim.cmd.cclose()
    vim.cmd.lclose()
    vim.cmd.NvimTreeClose()
    vim.cmd.FloatermHide()
    vim.cmd.UndotreeHide()
    require('dap').repl.close()

    vim.cmd.windo('if expand("%:t")=~#"dap-terminal" && &ft=="" | q | endif')
end

return This
