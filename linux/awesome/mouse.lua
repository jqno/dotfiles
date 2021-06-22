local This = {}

local awful = require('awful')
local constants = require('constants')
local gears = require('gears')

local modkey = constants.modkey
local left = constants.button_left
local right = constants.button_right


This.client_buttons = gears.table.join(
  awful.button({}, left, function(c)
    c:emit_signal('request::activate', 'mouse_click', { raise = true })
  end),
  awful.button({ modkey }, left, function(c)
    c:emit_signal('request::activate', 'mouse_click', { raise = true })
    awful.mouse.client.move(c)
  end),
  awful.button({ modkey, 'Shift' }, left, function(c)
    c:emit_signal('request::activate', 'mouse_click', { raise = true })
    awful.mouse.client.resize(c)
  end)
)

This.layoutbox_buttons = gears.table.join(
  awful.button({}, left, function() awful.layout.inc(1) end),
  awful.button({}, right, function() awful.layout.inc(-1) end)
)

This.taglist_buttons = gears.table.join(
  awful.button({}, left, function(t) t:view_only() end),
  awful.button({}, right, awful.tag.viewtoggle)
)

This.tasklist_buttons = gears.table.join(
  awful.button({}, left, function(c)
    c:emit_signal('request::activate', 'tasklist', { raise = true })
  end),
  awful.button({ }, right, function()
    awful.menu.client_list({ theme = { width = 250 } })
  end)
)

return This
