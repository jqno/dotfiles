return {
    'alvan/vim-closetag',
    ft = { 'html', 'xml' },

    init = function()
        vim.g.closetag_filetypes = 'html,xml'
    end
}
