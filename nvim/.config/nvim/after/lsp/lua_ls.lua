return {
    settings = {
        Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = { globals = { 'vim', 'require' } },
            telemetry = { enable = false },
            hint = { enable = true }
        }
    }
}
