local This = {}

function This.setup()
  require('filetypes.markdown')

  local modes = require('mappings').modes
  require('vim-util').buf_map(0, modes.i, '<CR>', 'pumvisible() ? v:lua.compe.cr_complete() : "<C-]><Esc>:VimwikiReturn 1 5<CR>"', { silent = true, expr = true })
end

return This
