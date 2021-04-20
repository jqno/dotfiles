local M = {}
local vim_util = require('vim-util')


function M.setup()
  vim_util.augroup('configure_filetypes', [[
    autocmd FileType java     lua require('filetypes.java').setup()
    autocmd FileType markdown lua require('filetypes.markdown').setup()
    autocmd FileType vimwiki  lua require('filetypes.vimwiki').setup()
  ]])

  vim_util.augroup('recognise_filetypes', [[
    autocmd BufRead,BufNewFile *.worksheet.sc set filetype=scala
  ]])
end


return M
