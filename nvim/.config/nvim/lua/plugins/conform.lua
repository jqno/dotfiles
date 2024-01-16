local function autoformat(params)
    local p = params or {}
    local async = p.async or false
    local bufnr = p.bufnr or vim.fn.bufnr()

    if vim.g.do_autoformat or vim.b[bufnr].do_autoformat then
        if require('util.is-editable').is_editable(bufnr) then
            require('conform').format({ bufnr = bufnr, async = async, lsp_fallback = true })
        end
    end
end

local This = {
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

        local group = vim.api.nvim_create_augroup('AutoFormat', { clear = true })
        vim.api.nvim_create_autocmd({ 'FocusLost' }, {
            group = group,
            pattern = '*',
            callback = function(args)
                autoformat({ bufnr = args.buf, async = true })
            end
        })
        vim.api.nvim_create_autocmd({ 'BufLeave' }, {
            group = group,
            pattern = '*',
            callback = function(args)
                -- For some reason, for Lua files, diagnostics in floating windows clash with the BufLeave event
                if vim.bo.filetype ~= 'lua' then
                    autoformat({ bufnr = args.buf, async = true })
                end
            end
        })
    end,

    autoformat = autoformat
}

return This
