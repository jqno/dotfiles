return {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    branch = 'main',
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
        'RRethy/nvim-treesitter-endwise'
    },

    init = function()
        vim.api.nvim_create_autocmd('FileType', {
            callback = function()
                -- Enable treesitter highlighting and disable regex syntax
                pcall(vim.treesitter.start)
                -- Enable treesitter-based indentation
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })
        require('nvim-treesitter').install({
            'comment', 'diff',
            'bash', 'css', 'hocon', 'html', 'http', 'java', 'javascript', 'json',
            'kotlin', 'lua', 'make', 'markdown', 'nix', 'python', 'regex',
            'ruby', 'rust', 'scala', 'scss', 'sql', 'typescript', 'vim', 'vimdoc',
            'xml', 'yaml'
        })
    end
}
