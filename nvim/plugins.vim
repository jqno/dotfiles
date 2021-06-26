let g:plugin_lockfile = '$HOME/.config/nvim/plugin.lock.vim'
let g:metals_server_version = '0.10.2'


call plug#begin(stdpath('data') . '/plugged')

Plug 'alvan/vim-closetag'
Plug 'ayu-theme/ayu-vim'
Plug 'farmergreg/vim-lastplace'
Plug 'folke/which-key.nvim'
Plug 'folke/zen-mode.nvim'
Plug 'gcmt/wildfire.vim'
Plug 'glepnir/galaxyline.nvim'
Plug 'glepnir/lspsaga.nvim'
Plug 'hrsh7th/nvim-compe'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'jqno/jqno-autoclose.vim'
Plug 'kabouzeid/nvim-lspinstall'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'lewis6991/gitsigns.nvim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'machakann/vim-sandwich'
Plug 'mfussenegger/nvim-dap'
Plug 'mfussenegger/nvim-jdtls'
Plug 'neovim/nvim-lspconfig'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'prettier/vim-prettier', { 'do': 'yarn install', 'for': ['java'] }
Plug 'romainl/vim-cool'
Plug 'scalameta/nvim-metals'
Plug 'SirVer/ultisnips'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'
Plug 'vimwiki/vimwiki'
Plug 'wincent/terminus'

call plug#end()
