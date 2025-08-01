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
            package <pkg>

            <typ> <name><impl>:
              <body>
            ]],
            {
                pkg = f(function() return require('util.java').get_package_for_language('scala') end),
                typ = c(1, { t('class'), t('case class'), t('object'), t('trait') }),
                name = f(function() return vim.fn.expand('%:t:r') end),
                impl = i(2, ''),
                body = i(0, '')
            })),
    parse({ trig = 'comment', dscr = 'Comment' },
        [[
        /*
         * $1
         */$0
        ]]),
    parse({ trig = 'doccomment', dscr = 'Scaladoc comment' },
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
