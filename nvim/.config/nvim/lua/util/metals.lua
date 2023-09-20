local This = {}

function This.metals_config(capabilities)
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

return This
