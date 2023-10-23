local function load()
    require('luasnip.loaders.from_lua').lazy_load({
        paths = { vim.fn.stdpath('config') .. '/lua/snippets' }
    })
end

local function reload()
    load()
    print('Snippets reloaded')
end

return {
    'L3MON4D3/LuaSnip',
    lazy = true,

    config = function()
        load()
        local types = require('luasnip.util.types')

        require('luasnip').config.setup({
            region_check_events = 'CursorHold',
            update_events = { 'TextChanged', 'TextChangedI' },
            ext_opts = {
                [types.choiceNode] = {
                    active = { virt_text = { { '●', 'GitSignsChange' } } }
                }
            }
        })
    end,

    reload = reload
}
