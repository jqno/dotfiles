local This = {}

local awesome = _G.awesome
local awful = require('awful')
local hotkeys_popup = require('awful.hotkeys_popup')
local util = require('util')

-- Load Debian menu entries
local debian = require('debian.menu')
local has_fdo, freedesktop = pcall(require, 'freedesktop')


local awesome_menu = {
  { 'hotkeys', function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
  { 'manual', util.terminal .. ' -e man awesome' },
  { 'edit config', util.editor_cmd .. ' ' .. awesome.conffile },
  { 'restart', awesome.restart },
  { 'quit', function() awesome.quit() end },
}

local menu_awesome = { "Awesome", awesome_menu }
local menu_terminal = { "Open terminal", terminal }

This.main = nil

function This.setup()
  if has_fdo then
    This.main = freedesktop.menu.build({
      before = { menu_awesome },
      after =  { menu_terminal }
    })
  else
    This.main = awful.menu({
      items = {
        menu_awesome,
        { "Debian", debian.menu.Debian_menu.Debian },
        menu_terminal,
      }
    })
  end
end

return This
