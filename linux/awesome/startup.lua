local awful = require('awful')
local script = require('util').script

local function run(cmd)
  awful.spawn.easy_async_with_shell(cmd)
end

local autostart_apps = {
  script('display.sh'),
  'picom -b -f',
  'dropbox start',
  'xautolock -time 2 -locker "' .. script('lock.sh') .. '"'
}

for app = 1, #autostart_apps do
  run(autostart_apps[app])
end

