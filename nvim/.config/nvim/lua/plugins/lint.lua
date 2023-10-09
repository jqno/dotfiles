return {
    'mfussenegger/nvim-lint',
    event = 'BufReadPre',

    config = function()
        local lint = require('lint')

        -- Configure linters
        lint.linters_by_ft = {
            dockerfile = { 'hadolint' },
            markdown = { 'markdownlint', 'vale' },
            yaml = { 'actionlint' }
        }

        -- Codespell
        local codespell_languages = { 'java', 'javascript', 'lua', 'markdown', 'python', 'scala', 'text', 'typescript' }
        for _, lang in ipairs(codespell_languages) do
            if lint.linters_by_ft[lang] then
                table.insert(lint.linters_by_ft[lang], 'codespell')
            else
                lint.linters_by_ft[lang] = { 'codespell' }
            end
        end

        -- Set up autocmd
        vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufWritePost' }, {
            group = vim.api.nvim_create_augroup('NvimLint', { clear = true }),
            callback = function()
                lint.try_lint()
            end,
        })
    end
}
