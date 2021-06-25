local This = {}

local awful = require('awful')
local util = require('util')

local autostart_apps = {
  util.script('display.sh'),
  'nm-applet',
  'blueman-applet',
  'numlockx on',
  'picom -b -f',
  'dropbox start',
  'xautolock -time 2 -locker "' .. util.script('lock.sh') .. '"',
  'rambox',
  'teams',
  'mailspring',
  'firefox',
  'feh --randomize --bg-fill ' .. util.location_wallpapers .. '*'
}

function This.setup()
  for app = 1, #autostart_apps do
    local cmd = autostart_apps[app]
    awful.spawn.easy_async_with_shell(cmd)
  end
end

return This
