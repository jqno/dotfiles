local awful = require('awful')

local function run(cmd)
  awful.spawn.easy_async_with_shell(cmd)
end

local autostart_apps = {
  '~/.config/awesome/scripts/display.sh',
  'picom -b -f',
  'dropbox start'
}

for app = 1, #autostart_apps do
  run(autostart_apps[app])
end

