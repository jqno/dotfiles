local ls = require('luasnip')
local s = ls.snippet
local f = ls.function_node

return {
    s({ trig = 'date', dscr = 'Date in DD-MM-YYYY format' },
        f(function() return os.date('%d-%m-%Y') end)),

    s({ trig = 'dd', dscr = 'Date in YYYY-MM-DD format' },
        f(function() return os.date('%Y-%m-%d') end))
}
