call plug#begin(stdpath('data') . '/plugged')

Plug 'ChristianChiarulli/nvcode-color-schemes.vim', { 'commit': '90ee71d' }
Plug 'farmergreg/vim-lastplace', { 'commit': '8f6c445' }
Plug 'gcmt/wildfire.vim', { 'commit': 'e2baded' }  " Needed until Treesitter supports Scala
Plug 'glepnir/galaxyline.nvim', { 'commit': 'cbf64bd' }
Plug 'glepnir/lspsaga.nvim', { 'commit': '2bc15f3' }
Plug 'hrsh7th/nvim-compe', { 'commit': '888d9ec' }
Plug 'jqno/jqno-autoclose.vim', { 'commit': '69e83bb' }
Plug 'junegunn/goyo.vim', { 'commit': 'a865dec' }
Plug 'knubie/vim-kitty-navigator', { 'commit': 'f09007b' }
Plug 'kyazdani42/nvim-tree.lua', { 'commit': '090697e' }
Plug 'mfussenegger/nvim-jdtls', { 'commit': 'e16fb1b' }
Plug 'neovim/nvim-lspconfig', { 'commit': '5029746' }
Plug 'nvim-lua/plenary.nvim', { 'commit': 'a3276a4' }
Plug 'nvim-lua/popup.nvim', { 'commit': 'bc98ca6' }
Plug 'nvim-telescope/telescope.nvim', { 'commit': 'f2c3f72' }
Plug 'nvim-telescope/telescope-fzy-native.nvim', { 'commit': '7b3d252' }
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate', 'commit': '2abad14' }
Plug 'nvim-treesitter/nvim-treesitter-textobjects', { 'commit': '83fab05' }
Plug 'romainl/vim-cool', { 'commit': '27ad4ec' }
Plug 'scalameta/nvim-metals', { 'commit': '381fd8c' }
Plug 'SirVer/ultisnips', { 'commit': 'b974a13' }
Plug 'tjdevries/nlua.nvim', { 'commit': 'c0e8fbc' }
Plug 'tpope/vim-commentary', { 'commit': '349340d' }
Plug 'tpope/vim-endwise', { 'commit': '4289889' }
Plug 'tpope/vim-eunuch', { 'commit': 'dbbbf85' }
Plug 'vimwiki/vimwiki', { 'commit': '619f04f' }
Plug 'wincent/terminus', { 'commit': '51c9bf4' }

let g:metals_server_version = '0.10.1'

call plug#end()
