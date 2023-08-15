local ls = require('luasnip')
local parse = ls.parser.parse_snippet

return {
    parse({ trig = 'comment', dscr = 'Comment' },
        [[
        /*
         * $1
         */$0
        ]]),
    parse({ trig = 'scaladoc', dscr = 'Scaladoc comment' },
        [[
        /**
            * $1
            */$0
        ]]),
    parse({ trig = 'wartremover', dscr = 'Wartremover suppression' },
        [[@SuppressWarnings(Array("org.wartremover.warts.$0"))]]),
    parse({ trig = 'ignore', dscr = 'Scalastyle suppression' },
        [[// scalastyle:ignore]])
}
