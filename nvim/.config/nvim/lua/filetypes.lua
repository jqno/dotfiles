local This = {}

local vim_util = require('vim-util')

function This.setup()
    vim_util.augroup('configure_filetypes', [[
    autocmd FileType asciidoc lua require('filetypes.asciidoc').setup()
    autocmd FileType xml      lua require('filetypes.xml').setup()
    autocmd FileType lua      lua require('filetypes.lua').setup()
    autocmd FileType java     lua require('filetypes.java').setup()
    autocmd FileType markdown lua require('filetypes.markdown').setup()
    autocmd FileType python   lua require('filetypes.python').setup()
    autocmd FileType fugitiveblame lua require('filetypes.fugitiveblame').setup()
  ]])

    vim_util.augroup('recognise_filetypes', [[
    autocmd BufRead,BufNewFile pom.xml        set filetype=xml.pom
    autocmd BufRead,BufNewFile *.worksheet.sc set filetype=scala
  ]])
end

return This
