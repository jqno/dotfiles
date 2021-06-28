local This = {}

local awful = require('awful')
local client = _G.client
local root = _G.root

This.terminal = 'kitty'
This.editor = This.terminal .. ' -e ' .. (os.getenv('EDITOR') or 'editor')

This.location_scripts = '~/.config/awesome/scripts/'
This.location_wallpapers = '~/Dropbox/wallpapers/'
This.change_background = 'feh --randomize --bg-fill ' .. This.location_wallpapers .. '*'
This.choose_known_background = 'feh --bg-fill ' .. This.location_wallpapers .. '2017-05-31*Kopenhagen*3*.jpg'

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

function This.view_next(class)
  -- Maybe not the best way to find the current tag (a client might have multiple
  -- and screen.focused().selected_tag always returns the one where the mouse is
  -- but that doesn't necessarily have focus), but it will do for now.
  local current_tag = client.focus and client.focus.first_tag or awful.screen.focused().selected_tag
  local all_tags = root.tags()
  local found_current = false

  -- Iterate over all tags, but start after the current one.
  -- Ignore the ones at the beginning, then iterate over the rest,
  -- and iterate over the first ones again
  for _ = 1,2 do
    for _, t in ipairs(all_tags) do
      if found_current then
        for _, c in ipairs(t:clients()) do
          if c.class == class then
            awful.screen.focus(t.screen)
            t:view_only()
            return
          end
        end
      elseif t == current_tag then
        found_current = true
      end
    end
  end
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

function This.run_once(cmd, args)
  awful.spawn.easy_async_with_shell('pgrep -u "$USER" "^' .. cmd .. '$"',
    function(_, _, _, exitcode)
      if exitcode ~= 0 then
        awful.spawn(cmd .. ' ' .. args)
      end
    end)
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

function This.debug_popup(msg)
  local naughty = require('naughty')
  naughty.notify({
    preset = naughty.config.presets.critical,
    title = 'debug',
    text = tostring(msg)
  })
end

return This
