local am = require('app-management')
local caffeine = require('caffeine')
local clamshell = require('clamshell-monitor')
local hyper = require('hyper')


-- Secretaresse: sync calendars
_G.secretaresseDir = '~/.secretaresse'
dofile("/Users/jqno/.secretaresse/secretaresse.lua")


-- Activate plugins
caffeine.activate()
clamshell.activate()
hyper.activate("F18", "F17")


-- Quick reloading
hyper.bindKey({"cmd"}, "r", hs.reload)


-- App switching
hyper.bindKey({}, "return", function() am.switchToAndFromApp("net.kovidgoyal.kitty") end)
hyper.bindKey({}, "c", function() am.switchToAndFromApp("com.apple.iCal") end)
hyper.bindKey({}, "f", function() am.switchToAndFromApp("com.apple.finder") end)
hyper.bindKey({}, "m", function() am.switchToAndFromApp("com.postbox-inc.postbox") end)
hyper.bindKey({"cmd"}, "m", function() am.switchToAndFromApp("com.microsoft.Outlook") end)
hyper.bindKey({}, "n", function() am.switchToAndFromApp("net.cozic.joplin-desktop") end)
hyper.bindKey({}, "r", function() am.switchToAndFromApp("com.rememberthemilk.Deskmilk") end)
hyper.bindKey({}, "\\", function() am.switchToAndFromApp("com.hicknhacksoftware.MacPass") end)
hyper.bindKey({}, "s", function() am.switchToAndFromApp("com.spotify.client") end)
hyper.bindKey({}, "v", function() am.switchToAndFromApp("org.vim.MacVim") end)
hyper.bindKey({}, "w", function() am.switchToAndFromApp("org.mozilla.firefox") end)
hyper.bindKey({}, "1", function() am.switchToAndFromApp("com.grupovrs.ramboxce") end)
hyper.bindKey({}, "2", function() am.switchToAndFromAppNoLaunch("com.google.Chrome") end)

local kitty = "/usr/local/bin/kitty @ --to unix:/tmp/kitty-socket new-window --window-type os"
hyper.bindKey({"cmd"}, "return", function() hs.execute(kitty) end)


-- Window management
local yabai = "/usr/local/bin/yabai -m "
local yabai = function(cmd)
    hs.execute(yabai .. cmd)
end

hyper.bindKey({}, "left", function() hs.window.focusedWindow().focusWindowWest() end)
hyper.bindKey({}, "down", function() hs.window.focusedWindow().focusWindowSouth() end)
hyper.bindKey({}, "up", function() hs.window.focusedWindow().focusWindowNorth() end)
hyper.bindKey({}, "right", function() hs.window.focusedWindow().focusWindowEast() end)

hyper.bindKey({"cmd"}, "left", function() hs.window.focusedWindow():moveOneScreenWest() end)
hyper.bindKey({"cmd"}, "down", function() hs.window.focusedWindow():moveOneScreenSouth() end)
hyper.bindKey({"cmd"}, "up", function() hs.window.focusedWindow():moveOneScreenNorth() end)
hyper.bindKey({"cmd"}, "right", function() hs.window.focusedWindow():moveOneScreenEast() end)

hyper.bindKey({"cmd", "shift"}, "left", function() yabai("window --swap west") end)
hyper.bindKey({"cmd", "shift"}, "down", function() yabai("window --swap south") end)
hyper.bindKey({"cmd", "shift"}, "up", function() yabai("window --swap north") end)
hyper.bindKey({"cmd", "shift"}, "right", function() yabai("window --swap east") end)

hyper.bindKey({"cmd"}, "1", function() yabai("window --toggle float"); yabai("window --grid 1:1:1:1:1:1") end)
hyper.bindKey({"cmd"}, "2", function() yabai("window --toggle float"); yabai("window --grid 9:9:1:1:7:7") end)
hyper.bindKey({"cmd"}, "3", function() yabai("space --rotate 90") end)


-- Lock the screen
hyper.bindKey({}, "f12", function()
  -- hs.caffeinate.lockScreen()
  hs.caffeinate.startScreensaver()
end)


-- Show the bundleID of the currently open window
hyper.bindKey({"cmd"}, 'b', function() 
  local bundleId = hs.window.focusedWindow():application():bundleID()
  hs.alert.show(bundleId)
  hs.pasteboard.setContents(bundleId)
end)


-- Show the time
hyper.bindKey({}, "t", function()
  local time = os.date("%H:%M")
  hs.alert.show("🕓 " .. time)
  hs.pasteboard.setContents(time)
end)

hyper.bindKey({}, "d", function()
  local time = os.date("%Y-%m-%d")
  hs.alert.show("📆 " .. time)
  hs.pasteboard.setContents(time)
end)


-- Show the battery status
hyper.bindKey({}, "b", function()
  hs.alert.show("🔋 " .. hs.battery.percentage() .. "%")
end)


-- Loaded successfully!
hs.alert.show('🔨🥄✅')

