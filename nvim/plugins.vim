call plug#begin(stdpath('data') . '/plugged')

Plug 'ChristianChiarulli/nvcode-color-schemes.vim', { 'commit': '3164eaa' }
Plug 'farmergreg/vim-lastplace', { 'commit': '8f6c445' }
Plug 'gcmt/wildfire.vim', { 'commit': 'e2baded' }
Plug 'glepnir/galaxyline.nvim', { 'commit': '19488f5' }
Plug 'hrsh7th/nvim-compe', { 'commit': 'a392842' }
Plug 'jqno/jqno-autoclose.vim', { 'commit': '69e83bb' }
Plug 'jqno/jqno-textobj-functioncall.vim', { 'commit': '42dfe11' }
Plug 'junegunn/goyo.vim', { 'commit': 'a865dec' }
Plug 'knubie/vim-kitty-navigator', { 'commit': 'f09007b' }
Plug 'kyazdani42/nvim-tree.lua', { 'commit': 'de93da7' }
Plug 'mfussenegger/nvim-jdtls', { 'commit': '4ebad2d' }
Plug 'neovim/nvim-lspconfig', { 'commit': 'f978505' }
Plug 'nvim-lua/plenary.nvim', { 'commit': '2768ba7' }
Plug 'nvim-lua/popup.nvim', { 'commit': 'bc98ca6' }
Plug 'nvim-telescope/telescope.nvim', { 'commit': 'a7fa604' }
Plug 'nvim-telescope/telescope-fzy-native.nvim', { 'commit': '654dffd' }
Plug 'romainl/vim-cool', { 'commit': '27ad4ec' }
Plug 'scalameta/nvim-metals', { 'commit': '63b8b75' }
Plug 'SirVer/ultisnips', { 'commit': 'b974a13' }
Plug 'tjdevries/nlua.nvim', { 'commit': 'c0e8fbc' }
Plug 'tpope/vim-commentary', { 'commit': '349340d' }
Plug 'tpope/vim-endwise', { 'commit': '4289889' }
Plug 'tpope/vim-eunuch', { 'commit': 'dbbbf85' }
Plug 'wincent/terminus', { 'commit': '51c9bf4' }

let g:metals_server_version = '0.10.0'

call plug#end()
