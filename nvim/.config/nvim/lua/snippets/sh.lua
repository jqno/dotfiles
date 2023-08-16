local ls = require('luasnip')
local parse = ls.parser.parse_snippet

return {
    parse({ trig = 'shebang', dscr = 'Shebang' },
        [[
        #!/usr/bin/env sh


        ]]),

    parse({ trig = 'directory', dscr = "Get the script's source directory" },
        [[
        SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

        ]]),

    parse({ trig = 'safe', dscr = 'Enable all safety options' },
        [[
        set -euo pipefail

        ]]),

    parse({ trig = 'ifempty', dscr = 'If string is empty' },
        [==[
        if [[ -z "$$1" ]]; then
            $0
        fi
        ]==]),

    parse({ trig = 'ifnotempty', dscr = 'If string is not empty' },
        [==[
        if [[ -n "$$1" ]]; then
            $0
        fi
        ]==]),

    parse({ trig = 'ifexists', dscr = 'If file exists' },
        [==[
        if [[ -f "$$1" ]]; then
            $0
        fi
        ]==]),

    parse({ trig = 'ifdirectory', dscr = 'If file is a directory' },
        [==[
        if [[ -d "$$1" ]]; then
            $0
        fi
        ]==]),

    parse({ trig = 'xpidfile', dscr = 'Run only once, using a PID file' },
        [==[
        ### PID-file logic to make sure that the script only runs once
        ### See https://youtu.be/ylohuR0fzz4?t=551 for an explanation
        PIDFILE=$1
        function cleanup() {
          rm "\$PIDFILE"
        }
        if [[ -f \$PIDFILE ]]; then
          pid=$(cat "\$PIDFILE")
            if ps -p "\$pid" > /dev/null 2>&1; then
              echo "Script is already running"
              exit 1
            else
              # process not found; overwrite
              echo $$ > "\$PIDFILE"
            fi
        else
          # wasn't running; write pid
          echo $$ > "\$PIDFILE"
        fi
        trap cleanup EXIT
        ### End of PID-file logic
        $0
        ]==])

}
