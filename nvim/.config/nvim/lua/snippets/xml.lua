local ls = require('luasnip')
local parse = ls.parser.parse_snippet

return {
    parse({ trig = 'comment', dscr = 'Comment' },
        [[<!-- $1 -->$0]]),
    parse({ trig = '<', dscr = 'Tag' },
        [[<$1>$2</$1>$0]])
}
