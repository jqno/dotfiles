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
            package <pkg>;
            <ann>
            public <type> <name><impl> {
                <body>
            }
            ]],
            {
                pkg = f(require('util.java').get_package),
                ann = i(1, ''),
                type = c(2, { t('class'), t('interface'), t('record'), t('enum') }),
                name = f(function() return vim.fn.expand('%:t:r') end),
                impl = i(3, ''),
                body = i(0, '')
            })),

    parse({ trig = 'main', dscr = 'main method' },
        [[
        public static void main(String...args) {
            $1
        }
        ]]),

    parse({ trig = 'importassertj', dscr = 'import AssertJ' },
        [[import static org.assertj.core.api.Assertions.assertThat;]]),

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
