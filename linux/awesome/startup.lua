local awful = require('awful')

local function run(cmd)
  awful.spawn.easy_async_with_shell(cmd)
end

local autostart_apps = {
  '~/.config/awesome/scripts/display.sh',
  'picom -b -f',
  'dropbox start',
  'xautolock -time 2 -locker "~/.config/awesome/scripts/lock.sh"'
}

for app = 1, #autostart_apps do
  run(autostart_apps[app])
end

