return {
    'embear/vim-localvimrc',

    init = function()
        vim.g.localvimrc_sandbox = 0
        vim.g.localvimrc_whitelist = { vim.env.HOME .. '/w' }
    end
}
