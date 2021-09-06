local This = {}

local vim_util = require('vim-util')


function This.setup()
  vim_util.augroup('configure_filetypes', [[
    autocmd FileType lua      lua require('filetypes.lua').setup()
    autocmd FileType java     lua require('filetypes.java').setup()
    autocmd FileType markdown lua require('filetypes.markdown').setup()
    autocmd FileType vimwiki  lua require('filetypes.vimwiki').setup()
  ]])

  vim_util.augroup('recognise_filetypes', [[
    autocmd BufRead,BufNewFile pom.xml        set filetype=xml.pom
    autocmd BufRead,BufNewFile *.worksheet.sc set filetype=scala
  ]])

  vim_util.augroup('format_on_save', [[
    autocmd BufWritePre *.java lua vim.lsp.buf.formatting_sync()
  ]])
end


return This
