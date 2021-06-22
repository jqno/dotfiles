local This = {}

local awesome = _G.awesome
local awful = require('awful')
local beautiful = require('beautiful')
local client = _G.client

local function configure_clients()
  client.connect_signal("manage", function (c)
    -- Set the windows as the slave,
    -- i.e. put it at the end of others instead of setting it master.
    if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
        and not c.size_hints.user_position
        and not c.size_hints.program_position then
      -- Prevent clients from being unreachable after screen count changes.
      awful.placement.no_offscreen(c)
    end
  end)
end

local function enable_focus_follows_mouse()
  client.connect_signal('mouse::enter', function(c)
    c:emit_signal('request::activate', 'mouse_enter', { raise = false })
  end)
end

local function highlight_focused_border()
  client.connect_signal('focus', function(c) c.border_color = beautiful.border_focus end)
  client.connect_signal('unfocus', function(c) c.border_color = beautiful.border_normal end)
end

function This.setup()
  configure_clients()
  enable_focus_follows_mouse()
  highlight_focused_border()
end

return This
