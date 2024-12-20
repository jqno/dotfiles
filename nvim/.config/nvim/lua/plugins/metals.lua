local function metals_config(capabilities)
    local cfg = require('metals').bare_config()
    cfg.capabilities = capabilities
    cfg.init_options = {
        statusBarProvider = 'on'
    }
    cfg.settings = {
        scalafixConfigPath = vim.env.HOME .. '/.scalafix.conf',

        inlayHints = {
            hintsInPatternMatch = { enable = false },
            implicitArguments = { enable = true },
            implicitConversions = { enable = true },
            inferredTypes = { enable = false },
            typeParameters = { enable = false }
        }
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
