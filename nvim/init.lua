-- Without this, `has("python")` causes `v:shell_error` to be non-0 on my machine,
-- which causes issues in at least VimPlug
vim.g.loaded_python_provider = 0

vim.cmd('source $HOME/.config/nvim/plugins.vim')
require 'settings'
require 'completion'
require 'lsp'
require 'mappings'
