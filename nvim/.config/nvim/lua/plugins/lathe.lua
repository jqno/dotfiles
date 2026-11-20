return {
    'ag-libs/lathe.nvim',
    ft = { 'java' },
    cmd = { 'LatheStart', 'LatheInit' },
    main = 'lathe',
    dependencies = { 'nvim-dap' }, -- must load before Lathe to enable :LatheDebug

    opts = function()
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        return {
            capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
        }
    end
}
