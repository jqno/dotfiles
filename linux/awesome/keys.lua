local This = {}

local apps = require('applications')
local awesome = _G.awesome
local awful = require('awful')
local client = _G.client
local constants = require('constants')
local gears = require('gears')
local hotkeys_popup = require('awful.hotkeys_popup')
local root = _G.root
local screens = require('screens')
local util = require('util')

local modkey = constants.modkey
local hyper = constants.hyper

local function generate_general_keys(merge_with)
  return gears.table.join(
    merge_with,

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
    awful.key({ modkey }, 'h', function () awful.client.focus.global_bydirection('left') end,
              { description = 'focus left', group = 'client' }),
    awful.key({ modkey }, 'j', function () awful.client.focus.global_bydirection('down') end,
              { description = 'focus down', group = 'client' }),
    awful.key({ modkey }, 'k', function () awful.client.focus.global_bydirection('up') end,
              { description = 'focus up', group = 'client' }),
    awful.key({ modkey }, 'l', function () awful.client.focus.global_bydirection('right') end,
              { description = 'focus right', group = 'client' }),
    awful.key({ modkey }, 'u', awful.client.urgent.jumpto,
              { description = 'jump to urgent client', group = 'client' }),

    -- launcher
    awful.key({ modkey }, 'Return', function () awful.spawn(util.terminal) end,
              { description = 'open a terminal', group = 'launcher' }),
    awful.key({ modkey }, 'space', function () awful.spawn('rofi -modi drun -show drun') end,
              { description = 'run prompt', group = 'launcher' }),

    -- layout
    awful.key({ modkey, 'Control', 'Shift' }, 'space', function () awful.layout.inc(-1) end,
              { description = 'select previous', group = 'layout' }),
    awful.key({ modkey, 'Control' }, 'space', function () awful.layout.inc(1) end,
              { description = 'select next', group = 'layout' }),
    awful.key({ modkey }, '=', function () awful.tag.incmwfact(-0.05) end,
              { description = 'decrease master width factor', group = 'layout' }),
    awful.key({ modkey }, '-', function () awful.tag.incmwfact(0.05) end,
              { description = 'increase master width factor', group = 'layout' }),

    -- screen
    awful.key({ modkey, 'Control' }, 'j', function () awful.screen.focus_relative(1) end,
              { description = 'focus the next screen', group = 'screen' }),
    awful.key({ modkey, 'Control' }, 'k', function () awful.screen.focus_relative(-1) end,
              { description = 'focus the previous screen', group = 'screen' }),

    -- system
    awful.key({ modkey, 'Control' }, 'r', awesome.restart,
              { description = 'reload awesome', group = 'system' }),
    awful.key({ modkey }, 'BackSpace', function() util.run_script('lock.sh') end,
              { description = 'power menu', group = 'system' }),
    awful.key({ modkey, "Shift" }, 'BackSpace', function() util.power_menu() end,
              { description = 'lock screen', group = 'system' }),
    awful.key({ modkey }, 'b', function() util.run(util.change_background) end,
              { description = 'change wallpaper', group = 'system' }),
    awful.key({ modkey, 'Shift' }, 'b', function() util.run(util.choose_known_background) end,
              { description = 'choose a known wallpaper', group = 'system' }),
    awful.key({ modkey }, 's', hotkeys_popup.show_help,
              { description = 'show help', group = 'system' }),
    awful.key({}, 'Print', function() util.run_script('scrot.sh') end,
              { description = 'take screenshot', group = 'system' }),
    awful.key({ 'Shift' }, 'Print', function() util.run_script('scrot.sh window') end,
              { description = 'take screenshot of window', group = 'system' }),

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
end

local function generate_app_keys(merge_with)
  local result = {}
  for name, app in pairs(apps.main) do
    local k = awful.key({ hyper }, app.hotkey, function() util.activate(app.executable, app.class) end,
                        { description = name, group = 'launcher' })
    result = gears.table.join(result, k)
  end
  return gears.table.join(merge_with, result)
end

local function key_for_tag(name)
  if name == screens.special_tag_names.terminal_1 then
    return '1'
  elseif name == screens.special_tag_names.terminal_2 then
    return '2'
  elseif name == screens.special_tag_names.terminal_3 then
    return '3'
  elseif name == screens.special_tag_names.terminal_4 then
    return '4'
  elseif name == screens.special_tag_names.music then
    return '5'
  elseif name == screens.special_tag_names.chat then
    return '6'
  elseif name == screens.special_tag_names.browse then
    return '7'
  else
    return name
  end
end

local function keys_for_tag(merge_with, tag)
  local key = key_for_tag(tag.name)
  return gears.table.join(
    merge_with,

    -- View tag only.
    awful.key({ hyper }, key,
              function()
                tag:view_only()
                awful.screen.focus(tag.screen)
              end,
              { description = 'view tag ' .. tag.name, group = 'tag' }),
    -- Move client to tag.
    awful.key({ hyper, modkey }, key,
              function()
                if client.focus then
                  client.focus:move_to_tag(tag)
                end
              end,
              { description = 'move focused client to tag ' .. tag.name, group = 'tag' }),
    -- Toggle tag on focused client.
    awful.key({ hyper, modkey, 'Control' }, key,
              function()
                if client.focus then
                  client.focus:toggle_tag(tag)
                end
              end,
              { description = 'toggle focused client on tag ' .. tag.name, group = 'tag' })
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

local function generate_all_keys()
  local all = generate_general_keys({})
  all = generate_app_keys(all)
  for _, t in ipairs(screens.tags) do
    all = keys_for_tag(all, t)
  end
  return all
end

function This.setup()
  local all = generate_all_keys()
  root.keys(all)
end

return This
