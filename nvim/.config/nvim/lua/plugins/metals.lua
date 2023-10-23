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
