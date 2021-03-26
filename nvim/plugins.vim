call plug#begin(stdpath('data') . '/plugged')

Plug 'hrsh7th/nvim-compe', { 'commit': 'a392842' }
Plug 'neovim/nvim-lspconfig', { 'commit': 'f978505' }
Plug 'tjdevries/nlua.nvim', { 'commit': 'c0e8fbc' }

call plug#end()
