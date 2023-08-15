local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local fmta = require("luasnip.extras.fmt").fmta

return {
    s({ trig = 'start', dscr = 'Start a new file' },
        fmta([[
            package <>;
            <>
            public <> <><> {
                <>
            }
            ]], {
            f(function() return vim.fn.expand('%:h'):match('src/.-/java/(.*)'):gsub('/', '.') end),
            i(1, ''),
            c(2, { t('class'), t('interface'), t('record'), t('enum') }),
            f(function() return vim.fn.expand('%:t:r') end),
            i(3, ''),
            i(0, '')
        }))
}
