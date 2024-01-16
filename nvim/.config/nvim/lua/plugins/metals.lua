local function metals_config(capabilities)
    local cfg = require('metals').bare_config()
    cfg.capabilities = capabilities
    cfg.init_options = {
        statusBarProvider = 'on'
    }
    cfg.settings = {
        showImplicitArguments = true,
        showImplicitConversionsAndClasses = true,
        showInferredType = true,
    }
    cfg.on_attach = function(client, bufnr)
        require('metals').setup_dap()
        require('config.mappings').setup_dap(bufnr)

        vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
            group = vim.api.nvim_create_augroup('LspAttachScala', { clear = true }),
            buffer = 0,
            callback = function()
                vim.lsp.codelens.refresh()
            end
        })
    end
    return cfg
end

return {
    'scalameta/nvim-metals',
    dependencies = {
        'nvim-lua/plenary.nvim'
    },
    ft = { 'scala' },

    metals_config = metals_config
}
