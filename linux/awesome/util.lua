local This = {}

local awful = require('awful')
local client = _G.client

This.terminal = 'kitty'
This.editor = This.terminal .. ' -e ' .. (os.getenv('EDITOR') or 'editor')

This.location_scripts = '~/.config/awesome/scripts/'
This.location_wallpapers = '~/Dropbox/wallpapers/'

local app_volume = 'pactl '
local app_player = 'playerctl '
local app_brightness = 'sudo brightnessctl set '

function This.activate(executable, class)
  for _, c in ipairs(client.get()) do
    if c.class == class then
      c.first_tag:view_only()
      client.focus = c
      c:raise()
      return
    end
  end

  awful.spawn(executable)
end

function This.find_tag(name)
  for _, t in ipairs(_G.root.tags()) do
    if t.name == name then
      return t
    end
  end
  return nil
end

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

function This.power_menu()
  This.run('rofi -show p -modi p:' .. This.location_scripts .. 'rofi-power-menu -lines 3')
end

return This
