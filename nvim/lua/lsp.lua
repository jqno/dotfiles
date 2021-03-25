local lsp = require'lspconfig'

local on_attach = function(client, bufnr)
  -- do stuff
end

require('nlua.lsp.nvim').setup(lsp, {
  on_attach = on_attach
})
