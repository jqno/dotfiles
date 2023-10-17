return {
    'stevearc/conform.nvim',
    event = 'UIEnter',

    config = function()
        require('conform').setup({
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
                    args = { '--stdin-filepath',
                        '--plugin=/home/linuxbrew/.linuxbrew/lib/node_modules/prettier-plugin-java/dist/index.js',
                        '$FILENAME' }
                },
                configured_sql_formatter = {
                    command = 'sql-formatter',
                    args = { '--config', vim.env.HOME .. '/.sql-formatter.json', '$FILENAME' }
                }
            }
        })

        vim.api.nvim_create_autocmd({ 'FocusLost', 'WinLeave' }, {
            group = vim.api.nvim_create_augroup('AutoFormat', { clear = true }),
            pattern = '*',
            callback = function(args)
                if args.buf ~= nil and (vim.g.do_autoformat or vim.b[args.buf].do_autoformat) then
                    require('conform').format({ bufnr = args.buf, async = true, lsp_fallback = true })
                end
            end
        })
    end
}
