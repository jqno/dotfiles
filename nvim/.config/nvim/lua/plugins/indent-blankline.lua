return {
    'lukas-reineke/indent-blankline.nvim',
    event = 'UIEnter',

    config = function()
        vim.cmd [[highlight! link IndentBlanklineContextSpaceChar Whitespace]]
        require('indent_blankline').setup({
            char = '',
            space_char_blankline = ' ',
            show_current_context = true
        })
    end
}
