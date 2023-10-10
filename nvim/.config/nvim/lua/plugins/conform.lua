return {
    'stevearc/conform.nvim',
    event = 'UIEnter',

    opts = {
        formatters_by_ft = {
            java = { 'prettier_java' },
            markdown = { 'prettier' },
            sh = { 'shellharden' },
            sql = { 'configured_sql_formatter' },
            ['_'] = { 'trim_whitespace' }
        },
        formatters = {
            prettier_java = {
                command = 'prettier',
                args = { '--stdin-filepath', '--plugin=/home/linuxbrew/.linuxbrew/lib/node_modules/prettier-plugin-java/dist/index.js', '$FILENAME' }
            },
            configured_sql_formatter = {
                command = 'sql-formatter',
                args = { '--config', vim.env.HOME .. '/.sql-formatter.json', '$FILENAME' }
            }
        }
    }
}
