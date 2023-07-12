return {
    'L3MON4D3/LuaSnip',
    lazy = true,

    config = function()
        -- Adding snippets for a new filetype? Don't forget to update `snippets/package.json`!
        require('luasnip/loaders/from_vscode').lazy_load({
            paths = { vim.fn.stdpath('config') .. '/snippets' }
        })
        local types = require('luasnip.util.types')

        require('luasnip').config.setup({
            region_check_events = 'CursorHold',
            ext_opts = {
                [types.choiceNode] = {
                    active = { virt_text = { { '●', 'GitSignsChange' } } }
                }
            }
        })
    end
}
