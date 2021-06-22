local awful = require('awful')
local client = _G.client
local beautiful = require('beautiful')
local gears = require('gears')
local wibox = require('wibox')

local This = {}

local function setup_layouts()
  awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.max,
    awful.layout.suit.floating,
    awful.layout.suit.magnifier
  }
end

local function setup_theme()
  beautiful.init(gears.filesystem.get_themes_dir() .. "zenburn/theme.lua")
end

local function setup_titlebars()
  client.connect_signal('request::titlebars', function(c)
    awful.titlebar(c):setup {
      { -- Left
        awful.titlebar.widget.iconwidget(c),
        layout  = wibox.layout.fixed.horizontal
      },
      { -- Middle
        {
          align  = "center",
          widget = awful.titlebar.widget.titlewidget(c)
        },
        layout  = wibox.layout.flex.horizontal
      },
      { -- Right
        awful.titlebar.widget.closebutton(c),
        layout = wibox.layout.fixed.horizontal()
      },
      layout = wibox.layout.align.horizontal
    }
  end)
end

function This.setup()
  setup_layouts()
  setup_theme()
  setup_titlebars()
end

return This
