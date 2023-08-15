local ls = require('luasnip')
local parse = ls.parser.parse_snippet

return {
    parse({ trig = 'issue', dscr = 'EqualsVerifier issue reference' },
        [[([Issue $1](https://github.com/jqno/equalsverifier/issues/$1)$2)$0]]),
    parse({ trig = 'checkbox', dscr = 'A checkbox' },
        [==[- [ ]]==]),

    parse({ trig = 'nowrap', dscr = 'Vim modeline to disable wrapping in this file' },
        [[%% vim:nowrap]]),

    parse({ trig = 'prettier-ignore', dscr = 'Block which will not be formatted' },
        [[
        <!-- prettier-ignore-start -->
        $1
        <!-- prettier-ignore-end -->
        $0
        ]])
}
