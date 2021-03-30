call plug#begin(stdpath('data') . '/plugged')

Plug 'ChristianChiarulli/nvcode-color-schemes.vim', { 'commit': '3164eaa' }
Plug 'glepnir/galaxyline.nvim', { 'commit': '19488f5' }
Plug 'hrsh7th/nvim-compe', { 'commit': 'a392842' }
Plug 'mfussenegger/nvim-jdtls', { 'commit': '4ebad2d' }
Plug 'neovim/nvim-lspconfig', { 'commit': 'f978505' }
Plug 'nvim-lua/plenary.nvim', { 'commit': '2768ba7' }
Plug 'nvim-lua/popup.nvim', { 'commit': 'bc98ca6' }
Plug 'nvim-telescope/telescope.nvim', { 'commit': 'a7fa604' }
Plug 'scalameta/nvim-metals', { 'commit': '63b8b75' }
Plug 'tjdevries/nlua.nvim', { 'commit': 'c0e8fbc' }

let g:metals_server_version = '0.10.0'

call plug#end()
