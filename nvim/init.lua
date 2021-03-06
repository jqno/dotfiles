vim.cmd('source $HOME/.config/nvim/plugins.vim')

require('settings').setup()
require('completion').setup()
require('lsp').setup()
require('statusline').setup()
require('mappings').setup()
require('filetypes').setup()
require('plugin-settings').setup()
