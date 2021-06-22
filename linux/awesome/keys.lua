local This = {}

local apps = require('applications')
local awesome = _G.awesome
local awful = require('awful')
local client = _G.client
local gears = require('gears')
local hotkeys_popup = require('awful.hotkeys_popup')
local root = _G.root
local util = require('util')
local constants = require('constants')

local modkey = constants.modkey
local hyper = constants.hyper

local function generate_app_keys()
  local result = {}
  for name, app in pairs(apps.main) do
    local k = awful.key({ hyper }, app.hotkey, function() util.activate(app.executable, app.class) end,
                        { description = name, group = 'launcher' })
    result = gears.table.join(result, k)
  end
  return result
end

local global_keys = gears.table.join(
  generate_app_keys(),

  -- client
  awful.key({ modkey, 'Shift' }, 'j', function () awful.client.swap.byidx(1) end,
            { description = 'swap with next client by index', group = 'client' }),
  awful.key({ modkey, 'Shift' }, 'k', function () awful.client.swap.byidx(-1) end,
            { description = 'swap with previous client by index', group = 'client' }),
  awful.key({ modkey }, 'Tab',
            function ()
              awful.client.focus.history.previous()
              if client.focus then
                client.focus:raise()
              end
            end,
            { description = 'go back', group = 'client' }),
  awful.key({ modkey }, 'j', function () awful.client.focus.byidx(1) end,
            { description = 'focus next by index', group = 'client' }),
  awful.key({ modkey }, 'k', function () awful.client.focus.byidx(-1) end,
            { description = 'focus previous by index', group = 'client' }),
  awful.key({ modkey }, 'u', awful.client.urgent.jumpto,
            { description = 'jump to urgent client', group = 'client' }),

  -- launcher
  awful.key({ modkey }, 'Return', function () awful.spawn(apps.terminal) end,
            { description = 'open a terminal', group = 'launcher' }),
  awful.key({ modkey }, 'space', function () awful.spawn('rofi -modi drun -show drun') end,
            { description = 'run prompt', group = 'launcher' }),

  -- layout
  awful.key({ modkey, 'Control', 'Shift' }, 'space', function () awful.layout.inc(-1) end,
            { description = 'select previous', group = 'layout' }),
  awful.key({ modkey, 'Control' }, 'space', function () awful.layout.inc(1) end,
            { description = 'select next', group = 'layout' }),
  awful.key({ modkey }, 'h', function () awful.tag.incmwfact(-0.05) end,
            { description = 'decrease master width factor', group = 'layout' }),
  awful.key({ modkey }, 'l', function () awful.tag.incmwfact(0.05) end,
            { description = 'increase master width factor', group = 'layout' }),

  -- screen
  awful.key({ modkey, 'Control' }, 'j', function () awful.screen.focus_relative(1) end,
            { description = 'focus the next screen', group = 'screen' }),
  awful.key({ modkey, 'Control' }, 'k', function () awful.screen.focus_relative(-1) end,
            { description = 'focus the previous screen', group = 'screen' }),

  -- system
  awful.key({ modkey, 'Control', 'Shift' }, 'BackSpace', awesome.quit,
            { description = 'quit awesome', group = 'system' }),
  awful.key({ modkey, 'Control' }, 'r', awesome.restart,
            { description = 'reload awesome', group = 'system' }),
  awful.key({ modkey }, 'BackSpace', function() util.run_script('lock.sh') end,
            { description = 'lock screen', group = 'system' }),
  awful.key({ modkey }, 's', hotkeys_popup.show_help,
            { description = 'show help', group = 'system' }),

  -- tag
  awful.key({ modkey }, 'Escape', awful.tag.history.restore,
            { description = 'go back', group = 'tag' }),
  awful.key({ modkey }, 'Left', awful.tag.viewprev,
            { description = 'view previous', group = 'tag' }),
  awful.key({ modkey }, 'Right', awful.tag.viewnext,
            { description = 'view next', group = 'tag' }),

  -- special keys
  awful.key({}, 'XF86AudioRaiseVolume', function() util.adjust_volume('+5%') end),
  awful.key({}, 'XF86AudioLowerVolume', function() util.adjust_volume('-5%') end),
  awful.key({}, 'XF86AudioMute', function() util.mute() end),
  awful.key({}, 'XF86AudioPlay', function() util.player('play-pause') end),
  awful.key({}, 'XF86AudioPause', function() util.player('play-pause') end),
  awful.key({}, 'XF86AudioNext', function() util.player('next') end),
  awful.key({}, 'XF86AudioPrev', function() util.player('previous') end),
  awful.key({}, 'XF86MonBrightnessUp', function() util.adjust_brightness('10%+') end),
  awful.key({}, 'XF86MonBrightnessDown', function() util.adjust_brightness('10%-') end)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
  global_keys = gears.table.join(global_keys,
    -- View tag only.
    awful.key({ modkey }, '#' .. i + 9,
              function ()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                  tag:view_only()
                end
              end,
              { description = 'view tag #'..i, group = 'tag' }),
    -- Move client to tag.
    awful.key({ modkey, 'Shift' }, '#' .. i + 9,
              function ()
                if client.focus then
                  local tag = client.focus.screen.tags[i]
                  if tag then
                    client.focus:move_to_tag(tag)
                  end
                end
              end,
              { description = 'move focused client to tag #'..i, group = 'tag' }),
    -- Toggle tag on focused client.
    awful.key({ modkey, 'Control', 'Shift' }, '#' .. i + 9,
              function ()
                if client.focus then
                  local tag = client.focus.screen.tags[i]
                  if tag then
                    client.focus:toggle_tag(tag)
                  end
                end
              end,
              { description = 'toggle focused client on tag #' .. i, group = 'tag' })
  )
end

This.client_keys = gears.table.join(
  awful.key({ modkey }, 'f',
            function (c)
                c.fullscreen = not c.fullscreen
                c:raise()
            end,
            { description = 'toggle fullscreen', group = 'client' }),
  awful.key({ modkey, 'Shift' }, 'q', function (c) c:kill() end,
            { description = 'close', group = 'client' }),
  awful.key({ modkey }, 'o', function (c) c:move_to_screen() end,
            { description = 'move to next screen', group = 'client' })
)

function This.setup()
  root.keys(global_keys)
end

return This
