let g:plugin_lockfile = '$HOME/.config/nvim/plugin.lock.vim'
let g:metals_server_version = '0.10.2'


call plug#begin(stdpath('data') . '/plugged')

" Improve editing
Plug 'alvan/vim-closetag'
Plug 'AndrewRadev/tagalong.vim'
Plug 'gcmt/wildfire.vim'
Plug 'jqno/jqno-autoclose.vim'
Plug 'machakann/vim-sandwich'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'

" Improve navigation
Plug 'farmergreg/vim-lastplace'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'ludovicchabant/vim-gutentags'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'ThePrimeagen/harpoon'

" Improve looks
Plug 'glepnir/galaxyline.nvim'
Plug 'jqno/tranquility.nvim'
Plug 'kyazdani42/nvim-web-devicons'

" Improve UX
Plug 'folke/which-key.nvim'
Plug 'folke/zen-mode.nvim'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'lewis6991/gitsigns.nvim'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'romainl/vim-cool'
Plug 'tpope/vim-eunuch'
Plug 'wincent/terminus'

" Configure LSP and completion
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp'
Plug 'mfussenegger/nvim-dap'
Plug 'mfussenegger/nvim-jdtls'
Plug 'neovim/nvim-lspconfig'
Plug 'scalameta/nvim-metals'

" Configure Vimwiki
Plug 'ElPiloto/telescope-vimwiki.nvim'
Plug 'vimwiki/vimwiki'

" Dependencies
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }

call plug#end()
