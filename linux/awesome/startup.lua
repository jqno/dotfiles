local awful = require('awful')
local util = require('util')

local function run(cmd)
  awful.spawn.easy_async_with_shell(cmd)
end

local autostart_apps = {
  util.script('display.sh'),
  'feh --randomize --bg-fill ' .. util.location_wallpapers .. '*',
  'picom -b -f',
  'dropbox start',
  'xautolock -time 2 -locker "' .. util.script('lock.sh') .. '"'
}

for app = 1, #autostart_apps do
  run(autostart_apps[app])
end

