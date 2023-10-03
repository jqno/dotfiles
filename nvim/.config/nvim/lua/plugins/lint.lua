return {
    'mfussenegger/nvim-lint',
    event = 'BufReadPre',

    config = function()
        require('lint').linters_by_ft = {
            dockerfile = { 'hadolint' },
            markdown = { 'markdownlint', 'vale' },
            yaml = { 'actionlint' }
        }
        vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufWritePost' }, {
            group = vim.api.nvim_create_augroup('NvimLint', { clear = true }),
            callback = function()
                require('lint').try_lint()
            end,
        })
    end
}
