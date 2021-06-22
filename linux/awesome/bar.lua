local This = {}

local awful = require('awful')
local bar_menu = require('bar_menu')
local beautiful = require('beautiful')
local mouse = require('mouse')
local wibox = require('wibox')

local function create_taglist_for(screen)
  return awful.widget.taglist({
    screen = screen,
    filter = awful.widget.taglist.filter.all,
    buttons = mouse.taglist_buttons
  })
end

local function create_tasklist_for(screen)
  return awful.widget.tasklist({
    screen  = screen,
    filter  = awful.widget.tasklist.filter.currenttags,
    buttons = mouse.tasklist_buttons
  })
end

local function create_layoutbox_for(screen)
  local box = awful.widget.layoutbox(screen)
  box:buttons(mouse.layoutbox_buttons)
  return box
end

function This.create_for(screen)
  local menu = awful.widget.launcher({
    image = beautiful.awesome_icon,
    menu = bar_menu.main
  })

  local bar = awful.wibar({ position = 'top', screen = screen })

  bar:setup({
    layout = wibox.layout.align.horizontal,
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      menu,
      create_taglist_for(screen),
      awful.widget.prompt()
    },
    -- Middle widget
    create_tasklist_for(screen),
    { -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      wibox.widget.systray(),
      wibox.widget.textclock(),
      create_layoutbox_for(screen),
    },
  })

  return bar
end

return This
