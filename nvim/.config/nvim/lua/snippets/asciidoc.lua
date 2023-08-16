local ls = require('luasnip')
local parse = ls.parser.parse_snippet

return {
    parse({ trig = 'source', dscr = 'Source code snippet' },
        [[
        [source,$1]
        ----
        $2
        ----
        ]])
}
