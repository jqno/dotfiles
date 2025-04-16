local ls = require('luasnip')
local parse = ls.parser.parse_snippet

return {
    parse({ trig = 'start', dscr = 'Shebang' },
        [[
        #!/usr/bin/env python3


        ]]),

    parse({ trig = 'main', dscr = 'Main clause' },
        [[
        if __name__ == '__main__':
            $0
        ]])
}
