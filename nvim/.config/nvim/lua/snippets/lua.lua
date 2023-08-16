local ls = require('luasnip')
local parse = ls.parser.parse_snippet

return {
    parse({ trig = 'parse', dscr = 'Snippet parser' },
        [==[
        parse({ trig = '$1', dscr = '$2' },
            [[$3]])$0
        ]==])
}
