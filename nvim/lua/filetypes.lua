local M = {}
local util = require('util')
local settings = require('settings')

function M.markdown()
  vim.wo.wrap = true
end


function M.java()
  settings.set_buf_indent(4)
end


function M.setup()
  util.augroup('filetypes', [[
    autocmd FileType java     lua require('filetypes').java()
    autocmd FileType markdown lua require('filetypes').markdown()
  ]])
end

return M
