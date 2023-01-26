let g:plugin_lockfile = '$HOME/.config/nvim/plugin.lock.vim'


call plug#begin(stdpath('data') . '/plugged')

" Temporary workaround
Plug 'antoinemadec/FixCursorHold.nvim'

" Filetypes
Plug 'hashivim/vim-terraform'

" Improve editing
Plug 'akinsho/git-conflict.nvim'
Plug 'alvan/vim-closetag'
Plug 'AndrewRadev/tagalong.vim'
Plug 'gaoDean/autolist.nvim'
Plug 'gcmt/wildfire.vim'
Plug 'jqno/jqno-autoclose.vim'
Plug 'L3MON4D3/LuaSnip'
Plug 'machakann/vim-sandwich'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'Wansmer/sibling-swap.nvim'

" Improve navigation
Plug 'farmergreg/vim-lastplace'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'ludovicchabant/vim-gutentags'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }
Plug 'nvim-telescope/telescope-ui-select.nvim'
Plug 'tpope/vim-fugitive'

" Improve looks
Plug 'feline-nvim/feline.nvim'
Plug 'jqno/tranquility.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-treesitter/playground', { 'on': 'TSHighlightCapturesUnderCursor' }

" Improve UX
Plug 'embear/vim-localvimrc'
Plug 'folke/zen-mode.nvim'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'lewis6991/gitsigns.nvim'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'ojroques/nvim-bufdel'
Plug 'Pocco81/auto-save.nvim'
Plug 'romainl/vim-cool'
Plug 'tpope/vim-eunuch'
Plug 'vim-test/vim-test'
Plug 'voldikss/vim-floaterm'
Plug 'wincent/terminus'
Plug 'xorid/swap-split.nvim'

" Configure LSP and completion
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'mfussenegger/nvim-dap', { 'tag': '0.4.0' }
Plug 'mfussenegger/nvim-jdtls', { 'tag': '0.2.0' }
Plug 'neovim/nvim-lspconfig'
Plug 'saadparwaiz1/cmp_luasnip'

" Dependencies
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate \| :TSInstall markdown' }
Plug 'WhoIsSethDaniel/mason-tool-installer.nvim'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

call plug#end()
