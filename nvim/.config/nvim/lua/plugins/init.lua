return {
    'antoinemadec/FixCursorHold.nvim',

    -- Filetypes
    'hashivim/vim-terraform',

    -- Improve editing
    'akinsho/git-conflict.nvim',
    'alvan/vim-closetag',
    'AndrewRadev/tagalong.vim',
    'gaoDean/autolist.nvim',
    'gcmt/wildfire.vim',
    'jqno/jqno-autoclose.vim',
    'L3MON4D3/LuaSnip',
    'machakann/vim-sandwich',
    'mbbill/undotree',
    'nvim-treesitter/nvim-treesitter-textobjects',
    'tpope/vim-commentary',
    'tpope/vim-endwise',
    'Wansmer/sibling-swap.nvim',

    -- Improve navigation
    'farmergreg/vim-lastplace',
    'kyazdani42/nvim-tree.lua',
    'ludovicchabant/vim-gutentags',
    { 'nvim-telescope/telescope.nvim', tag = '0.1.1' },
    'nvim-telescope/telescope-ui-select.nvim',
    'ThePrimeagen/harpoon',
    'tpope/vim-fugitive',

    -- Improve looks
    'feline-nvim/feline.nvim',
    {
      'jqno/tranquility.nvim',
      config = function()
        vim.g.tranquility_overrides = { invert_statusline = true }
        vim.cmd.colorscheme('green-tranquility')
      end
    },
    'kyazdani42/nvim-web-devicons',
    'nvim-treesitter/playground', -- { 'on': 'TSHighlightCapturesUnderCursor' }

    -- Improve UX
    'embear/vim-localvimrc',
    'folke/zen-mode.nvim',
    'jeffkreeftmeijer/vim-numbertoggle',
    'lewis6991/gitsigns.nvim',
    'norcalli/nvim-colorizer.lua',
    'ojroques/nvim-bufdel',
    'Pocco81/auto-save.nvim',
    'romainl/vim-cool',
    'tpope/vim-eunuch',
    'vim-test/vim-test',
    'voldikss/vim-floaterm',
    'wincent/terminus',
    'xorid/swap-split.nvim',

    -- Configure LSP and completion
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'hrsh7th/nvim-cmp',
    'jose-elias-alvarez/null-ls.nvim',
    { 'mfussenegger/nvim-dap', tag = '0.4.0' },
    { 'mfussenegger/nvim-jdtls', tag = '0.2.0' },
    'neovim/nvim-lspconfig',
    'saadparwaiz1/cmp_luasnip',

    -- Dependencies
    'nvim-lua/plenary.nvim',
    'nvim-lua/popup.nvim',
    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
}
