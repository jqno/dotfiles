local ls = require('luasnip')
local parse = ls.parser.parse_snippet

return {
    parse({ trig = '#!', dscr = 'Shebang' },
        [[
        #!/usr/bin/env python


        ]]),

    parse({ trig = 'main', dscr = 'Main clause' },
        [[
        if __name__ == "main":
            $0
        ]])
}
