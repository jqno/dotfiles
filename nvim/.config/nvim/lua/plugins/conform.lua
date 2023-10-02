return {
    'stevearc/conform.nvim',
    lazy = true,

    opts = {
        formatters_by_ft = {
            java = { 'prettier' },
            markdown = { 'prettier' },
            sh = { 'shellharden' },
            sql = { 'configured_sql_formatter' }
        },
        formatters = {
            configured_sql_formatter = {
                command = 'sql-formatter',
                args = { '--config', vim.env.HOME .. '/.sql-formatter.json', '$FILENAME' }
            }
        }
    }
}
