local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local fmta = require("luasnip.extras.fmt").fmta
local parse = ls.parser.parse_snippet

return {
    s({ trig = 'start', dscr = 'Start a new file' },
        fmta([[
            package <>;
            <>
            public <> <><> {
                <>
            }
            ]],
            {
                f(function() return vim.fn.expand('%:h'):match('src/.-/java/(.*)'):gsub('/', '.') end),
                i(1, ''),
                c(2, { t('class'), t('interface'), t('record'), t('enum') }),
                f(function() return vim.fn.expand('%:t:r') end),
                i(3, ''),
                i(0, '')
            })),

    parse({ trig = 'main', dscr = 'main method' },
        [[
        public static void main(String...args) {
            $1
        }
        ]]),

    parse({ trig = 'sout', dscr = 'Print to System.out' },
        [[System.out.println($1);$0]]),

    parse({ trig = 'sysout', dscr = 'Print to System.out' },
        [[System.out.println($1);$0]]),

    parse({ trig = 'syserr', dscr = 'Print to System.err' },
        [[System.err.println($1);$0]]),

    parse({ trig = 'checkstyle', dscr = 'Checkstyle suppression' },
        [[
        // CHECKSTYLE OFF: $1

        ]]),

    parse({ trig = 'comment', dscr = 'Comment' },
        [[
        /*
         * $1
         */$0
        ]]),

    parse({ trig = 'doccomment', dscr = 'Javadoc comment' },
        [[
        /**
         * $1
         */$0
        ]]),

    parse({ trig = 'test', dscr = 'JUnit test case' },
        [[
        @Test
        ${1|void,public void|} $2() {
            $0
        }
        ]]),

    parse({ trig = 'assertEquals', 'assert that two values are equal' },
        [[
        assertEquals($1, $2);$0
        ]])
}
