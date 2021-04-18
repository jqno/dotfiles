local M = {}
local util = require('util')
local mappings = require('mappings')
local settings = require('settings')

function M.markdown()
  vim.wo.wrap = true
end


function M.java()
  settings.set_buf_indent(4)
end


function M.vimwiki()
  M.markdown()
  util.buf_map(0, mappings.modes.i, '<CR>', 'pumvisible() ? v:lua.compe.cr_complete() : "<C-]><Esc>:VimwikiReturn 1 5<CR>"', { silent = true, expr = true })
end


function M.setup()
  util.augroup('configure_filetypes', [[
    autocmd FileType java     lua require('filetypes').java()
    autocmd FileType markdown lua require('filetypes').markdown()
    autocmd FileType vimwiki  lua require('filetypes').vimwiki()
  ]])

  util.augroup('recognise_filetypes', [[
    autocmd BufRead,BufNewFile *.worksheet.sc set filetype=scala
  ]])
end

return M
