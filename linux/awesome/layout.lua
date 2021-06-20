local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")

local This = {}

local function setup_theme()
  beautiful.init(gears.filesystem.get_themes_dir() .. "zenburn/theme.lua")
end

local function setup_layouts()
  awful.layout.layouts = {
  awful.layout.suit.tile,
  awful.layout.suit.max,
  awful.layout.suit.floating,
  awful.layout.suit.magnifier
}
end

function This.setup()
  setup_theme()
  setup_layouts()
end

return This
