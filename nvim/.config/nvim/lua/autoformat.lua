local This = {}

local vim_util = require('vim-util')


This.do_autoformat = true


function This.setup()
  vim_util.augroup('format_on_save', [[
    autocmd BufWritePre *.java,*.lua lua require('autoformat').format()
  ]])
  vim.api.nvim_exec([[
    command! EnableAutoformat lua require('autoformat').do_autoformat = true
    command! DisableAutoformat lua require('autoformat').do_autoformat = false
  ]], false)
end


function This.format()
  if This.do_autoformat then
    vim.lsp.buf.formatting_sync()
  end
end


return This
