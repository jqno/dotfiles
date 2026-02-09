local function metals_config(capabilities)
    local cfg = require('metals').bare_config()
    cfg.capabilities = capabilities
    cfg.init_options = {
        statusBarProvider = 'off'
    }
    cfg.settings = {
        serverVersion = '1.6.5',
        defaultBspToBuildTool = true,
        enableBestEffort = true,
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
    ft = { 'scala', 'sbt' },

    metals_config = metals_config
}
