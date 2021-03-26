call plug#begin(stdpath('data') . '/plugged')

Plug 'hrsh7th/nvim-compe', { 'commit': 'a392842' }
Plug 'neovim/nvim-lspconfig', { 'commit': 'f978505' }
Plug 'nvim-lua/plenary.nvim', { 'commit': '2768ba7' }
Plug 'nvim-lua/popup.nvim', { 'commit': 'bc98ca6' }
Plug 'nvim-telescope/telescope.nvim', { 'commit': 'a7fa604' }
Plug 'tjdevries/nlua.nvim', { 'commit': 'c0e8fbc' }

call plug#end()
