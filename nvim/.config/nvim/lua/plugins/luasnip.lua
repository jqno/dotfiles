local function load()
    require('luasnip.loaders.from_lua').lazy_load({
        paths = { vim.fn.stdpath('config') .. '/lua/snippets' }
    })
end

local function reload()
    load()
    print('Snippets reloaded')
end

local function leave_snippet()
    if
        ((vim.v.event.old_mode == 's' and vim.v.event.new_mode == 'n') or vim.v.event.old_mode == 'i')
        and require('luasnip').session.current_nodes[vim.api.nvim_get_current_buf()]
        and not require('luasnip').session.jump_active
    then
        require('luasnip').unlink_current()
    end
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

        vim.api.nvim_create_autocmd('ModeChanged', {
            group = vim.api.nvim_create_augroup('ExitLuaSnipSnippet', { clear = true }),
            buffer = 0,
            callback = leave_snippet
        })
    end,

    reload = reload
}
