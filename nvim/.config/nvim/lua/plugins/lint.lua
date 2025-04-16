local function reduce_vale_severity()
    local lint = require('lint')
    local original_parser = lint.linters.vale.parser
    local reduced_parser = function(output, bufnr, linter_cwd)
        local issues = original_parser(output, bufnr, linter_cwd)
        for _, entry in ipairs(issues) do
            entry.severity = vim.diagnostic.severity.INFO
        end
        return issues
    end
    lint.linters.vale.parser = reduced_parser
end

return {
    'mfussenegger/nvim-lint',
    event = 'BufReadPre',

    config = function()
        local lint = require('lint')
        reduce_vale_severity()

        -- Configure linters
        lint.linters_by_ft = {
            dockerfile = { 'hadolint' },
            markdown = { 'markdownlint', 'vale' },
            python = { 'mypy' },
            ['yaml.github'] = { 'actionlint' }
        }

        -- Set up autocmd
        vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufWritePost' }, {
            group = vim.api.nvim_create_augroup('NvimLint', { clear = true }),
            callback = function()
                lint.try_lint()
            end,
        })
    end
}
