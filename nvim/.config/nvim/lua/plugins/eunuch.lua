return {
    'tpope/vim-eunuch',
    cmd = { 'Rename', 'Delete', 'Move', 'Mkdir', 'Wall', 'SudoWrite', 'SudoEdit' },

    init = function()
        vim.g.eunuch_no_maps = true
    end
}
