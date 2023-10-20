local ls = require('luasnip')
local parse = ls.parser.parse_snippet

return {
    parse({ trig = 'start', dscr = 'Start a new file' },
        [[
        local This = {}

        $1

        return This
        ]]
    ),

    parse({ trig = 'parse', dscr = 'Snippet parser' },
        [==[
        parse({ trig = '$1', dscr = '$2' },
            [[$3]])$0
        ]==])
}
