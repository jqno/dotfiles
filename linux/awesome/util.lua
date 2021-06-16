local This = {}

local awful = require('awful')


This.location_scripts = '~/.config/awesome/scripts/'
This.location_wallpapers = '~/Dropbox/wallpapers/'

local app_volume = 'pactl '
local app_player = 'playerctl '
local app_brightness = 'sudo brightnessctl set '

function This.script(name)
  return This.location_scripts .. name
end

function This.run(cmd)
  awful.spawn.with_shell(cmd)
end

function This.run_script(cmd)
  This.run(This.script(cmd))
end

function This.adjust_volume(amount)
  This.run(app_volume .. 'set-sink-volume @DEFAULT_SINK@ ' .. amount)
end

function This.mute()
  This.run(app_volume .. 'set-sink-mute @DEFAULT_SINK@ toggle')
end

function This.player(cmd)
  This.run(app_player .. cmd)
end

function This.adjust_brightness(amount)
  This.run(app_brightness .. amount)
end

return This
