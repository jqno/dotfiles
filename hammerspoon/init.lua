local am = require('app-management')
local wm = require('window-management')
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
hyper.bindKey({}, "d", function() am.switchToAndFromApp("com.kapeli.dashdoc") end)
hyper.bindKey({}, "f", function() am.switchToAndFromApp("com.apple.finder") end)
hyper.bindKey({}, "i", function() am.switchToAndFromApp("com.jetbrains.intellij") end)
hyper.bindKey({}, "m", function() am.switchToAndFromApp("it.bloop.airmail2") end)
hyper.bindKey({}, "n", function() am.switchToAndFromApp("net.cozic.joplin-desktop") end)
hyper.bindKey({}, "\\", function() am.switchToAndFromApp("com.hicknhacksoftware.MacPass") end)
hyper.bindKey({}, "s", function() am.switchToAndFromApp("com.spotify.client") end)
hyper.bindKey({}, "v", function() am.switchToAndFromApp("org.vim.MacVim") end)
hyper.bindKey({}, "w", function() am.switchToAndFromApp("org.mozilla.firefox") end)
hyper.bindKey({}, "1", function() am.switchToAndFromApp("com.grupovrs.ramboxce") end)


-- Window management
hyper.bindKey({}, "h", function() wm.fw().focusWindowWest() end)
hyper.bindKey({}, "j", function() wm.fw().focusWindowSouth() end)
hyper.bindKey({}, "k", function() wm.fw().focusWindowNorth() end)
hyper.bindKey({}, "l", function() wm.fw().focusWindowEast() end)

hyper.bindKey({"cmd"}, "h", wm.leftPressed, wm.leftReleased)
hyper.bindKey({"cmd"}, "j", wm.downPressed, wm.downReleased)
hyper.bindKey({"cmd"}, "k", wm.upPressed, wm.upReleased)
hyper.bindKey({"cmd"}, "l", wm.rightPressed, wm.rightReleased)

hyper.bindKey({"cmd"}, "1", function() wm.windowMaximize(0) end)
hyper.bindKey({"cmd"}, "2", function() wm.windowMaximize(1) end)
hyper.bindKey({"cmd"}, "3", function() wm.windowMaximize(2) end)
hyper.bindKey({"cmd"}, "4", function() wm.windowMaximize(3) end)

hyper.bindKey({"cmd"}, "left", function() wm.fw():moveOneScreenWest() end)
hyper.bindKey({"cmd"}, "down", function() wm.fw():moveOneScreenSouth() end)
hyper.bindKey({"cmd"}, "up", function() wm.fw():moveOneScreenNorth() end)
hyper.bindKey({"cmd"}, "right", function() wm.fw():moveOneScreenEast() end)

local layouts = {
  { bundle = "com.apple.iCal", func = function(win) wm.windowMaximize(1, win) end },
  { bundle = "com.apple.Safari", func = function(win) wm.windowMaximize(1, win) end },
  { bundle = "com.google.Chrome", func = function(win) wm.windowMaximize(1, win) end },
  { bundle = "com.grupovrs.ramboxce", func = function(win) wm.windowMaximize(0, win) end },
  { bundle = "com.hicknhacksoftware.MacPass", func = function(win) wm.windowMaximize(2, win) end },
  { bundle = "com.jetbrains.intellij", func = function(win) wm.windowMaximize(0, win) end },
  { bundle = "com.kapeli.dashdoc", func = function(win) wm.windowMaximize(1, win) end },
  { bundle = "com.spotify.client", func = function(win) wm.windowMaximize(0, win) end },
  { bundle = "it.bloop.airmail2", func = function(win) wm.windowMaximize(0, win) end },
  { bundle = "net.cozic.joplin-desktop", func = function(win) wm.windowMaximize(0, win) end },
  { bundle = "net.kovidgoyal.kitty", func = function(win) wm.windowMaximize(0, win) end },
  { bundle = "org.keepassx.keepassxc", func = function(win) wm.windowMaximize(2, win) end },
  { bundle = "org.mozilla.firefox", func = function(win) wm.windowMaximize(0, win) end }
}
hyper.bindKey({"cmd"}, "delete", function() wm.applyLayouts(layouts) end)
hyper.bindKey({}, "tab", function() wm.cycleScreen() end)


-- Lock the screen
hyper.bindKey({}, "f12", function()
  -- hs.caffeinate.lockScreen()
  hs.caffeinate.startScreensaver()
end)


-- Show the bundleID of the currently open window
hyper.bindKey({"cmd"}, "b", function() hs.alert.show(hs.window.focusedWindow():application():bundleID()) end)


-- Show the time
hyper.bindKey({}, "t", function()
  local time = os.date("%H:%M")
  hs.alert.show("🕓 " .. time)
  hs.pasteboard.setContents(time)
end)

hyper.bindKey({"cmd"}, "t", function()
  local time = os.date("%Y-%m-%d")
  hs.alert.show("📆 " .. time)
  hs.pasteboard.setContents(time)
end)

hyper.bindKey({}, "b", function()
  hs.alert.show("🔋 " .. hs.battery.percentage() .. "%")
end)


-- Loaded successfully!
hs.alert.show('🔨🥄✅')

