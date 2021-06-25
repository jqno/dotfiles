local This = {}

local awful = require('awful')
local bar = require('bar')
local screen = _G.screen
local layouts = awful.layout.suit

This.special_tag_names = {
  browse = '',
  chat = '',
  music = '',
  work = '¹',
  hobby = '²'
}

This.tags = {}

local function create_tag(s, name, layout, selected)
  local tag = awful.tag.add(name, {
    layout = layout,
    screen = s,
    selected = selected
  })
  table.insert(This.tags, tag)
end

local function single_screen(s)
  bar.create_for(s)

  create_tag(s, This.special_tag_names.music, layouts.max, false)
  create_tag(s, This.special_tag_names.chat, layouts.max, true)
  create_tag(s, This.special_tag_names.browse, layouts.tile, false)
  create_tag(s, This.special_tag_names.work, layouts.tile, false)
  create_tag(s, This.special_tag_names.hobby, layouts.tile, false)
  create_tag(s, '1', layouts.tile, false)
  create_tag(s, '2', layouts.tile, false)
  create_tag(s, '3', layouts.tile, false)
  create_tag(s, '4', layouts.tile, false)
  create_tag(s, '5', layouts.tile, false)
  create_tag(s, '6', layouts.tile, false)
  create_tag(s, '7', layouts.tile, false)
  create_tag(s, '8', layouts.tile, false)
  create_tag(s, '9', layouts.tile, false)
  create_tag(s, '0', layouts.tile, false)
end

local function dual_screen(a, b)
  bar.create_for(a)
  bar.create_for(b)

  create_tag(a, This.special_tag_names.music, layouts.max, false)
  create_tag(a, This.special_tag_names.chat, layouts.max, true)
  create_tag(a, This.special_tag_names.browse, layouts.tile, false)
  create_tag(a, '1', layouts.tile, false)
  create_tag(a, '2', layouts.tile, false)
  create_tag(a, '3', layouts.tile, false)
  create_tag(a, '4', layouts.tile, false)
  create_tag(a, '5', layouts.tile, false)

  create_tag(b, This.special_tag_names.work, layouts.tile, false)
  create_tag(b, This.special_tag_names.hobby, layouts.tile, false)
  create_tag(b, '6', layouts.tile, false)
  create_tag(b, '7', layouts.tile, false)
  create_tag(b, '8', layouts.tile, false)
  create_tag(b, '9', layouts.tile, false)
  create_tag(b, '0', layouts.tile, false)
end

function This.setup()
  if screen.count() == 1 then
    single_screen(screen[1])
  else
    dual_screen(screen[1], screen[2])
  end
end

return This
