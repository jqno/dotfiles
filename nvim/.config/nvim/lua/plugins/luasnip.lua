return {
    'L3MON4D3/LuaSnip',
    lazy = true,

    config = function()
        -- Adding snippets for a new filetype? Don't forget to update `snippets/package.json`!
        require('util.snippets').load()
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
    end
}
