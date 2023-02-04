return {
    -- Improve editing
    'akinsho/git-conflict.nvim',
    'alvan/vim-closetag',
    'AndrewRadev/tagalong.vim',
    'gcmt/wildfire.vim',
    'jqno/jqno-autoclose.vim',
    'L3MON4D3/LuaSnip',
    'machakann/vim-sandwich',
    'mbbill/undotree',
    'tpope/vim-commentary',
    'tpope/vim-endwise',

    -- Improve navigation
    'farmergreg/vim-lastplace',
    'ludovicchabant/vim-gutentags',
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.1',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-ui-select.nvim',
        }
    },
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = {
            'kyazdani42/nvim-web-devicons'
        }
    },
    {
        'ThePrimeagen/harpoon',
        dependencies = {
            'nvim-lua/plenary.nvim'
        }
    },
    'tpope/vim-fugitive',

    -- Improve looks
    {
        'feline-nvim/feline.nvim',
        dependencies = {
            'kyazdani42/nvim-web-devicons'
        }
    },
    {
        'jqno/tranquility.nvim',
        config = function()
            vim.g.tranquility_overrides = { invert_statusline = true }
            vim.cmd.colorscheme('green-tranquility')
        end
    },

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
    'cloudysake/swap-split.nvim',

    -- Configure LSP and completion
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
            'saadparwaiz1/cmp_luasnip'
        }
    },
    {
        'jose-elias-alvarez/null-ls.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim'
        }
    },
    { 'mfussenegger/nvim-dap', tag = '0.4.0' },
    { 'mfussenegger/nvim-jdtls', tag = '0.2.0' },
    'neovim/nvim-lspconfig',

    -- Dependencies
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
    },
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
        }
    },
    {
        'nvim-treesitter/playground',
        cmd = 'TSHighlightCapturesUnderCursor',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
        }
    },
    {
        'Wansmer/sibling-swap.nvim',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
        }
    },
    {
        'williamboman/mason.nvim',
        dependencies = {
            'WhoIsSethDaniel/mason-tool-installer.nvim',
            'williamboman/mason-lspconfig.nvim',
        }
    },
}
