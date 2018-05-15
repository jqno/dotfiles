local This = {}

local MAX = 12
local HALF = MAX / 2

local pressed = {
  left = false,
  down = false,
  up = false,
  right = false
}

hs.grid.setGrid(MAX .. 'x' .. MAX)
hs.grid.setMargins({5, 5})
hs.window.animationDuration = 0.05

local windowPosition = function(cell, window)
  if window == nil then
    window = hs.window.focusedWindow()
  end
  if window then
    local screen = window:screen()
    hs.grid.set(window, cell, screen)
  end
end

This.fw = function()
  return hs.window.focusedWindow()
end

local windowMoveLeft = function(window)
  windowPosition({x = 0, y = 0, w = HALF, h = MAX}, window)
end

local windowMoveDown = function(window)
  windowPosition({x = 0, y = HALF, w = MAX, h = HALF}, window)
end

local windowMoveUp = function(window)
  windowPosition({x = 0, y = 0, w = MAX, h = HALF}, window)
end

local windowMoveRight = function(window)
  windowPosition({x = HALF, y = 0, w = HALF, h = MAX}, window)
end

local windowMoveTopLeft = function(window)
  windowPosition({x = 0, y = 0, w = HALF, h = HALF}, window)
end

local windowMoveTopRight = function(window)
  windowPosition({x = HALF, y = 0, w = HALF, h = HALF}, window)
end

local windowMoveBottomLeft = function(window)
  windowPosition({x = 0, y = HALF, w = HALF, h = HALF}, window)
end

local windowMoveBottomRight = function(window)
  windowPosition({x = HALF, y = HALF, w = HALF, h = HALF}, window)
end

This.windowMaximize = function(factor, window)
  local newpos = {
    x = factor,
    y = factor,
    w = MAX - (factor * 2),
    h = MAX - (factor * 2)
  }
  windowPosition(newpos, window)
end

This.applyLayouts = function(layouts)
  for _, layout in ipairs(layouts) do
    local apps = hs.application.applicationsForBundleID(layout.bundle)
    for _, app in ipairs(apps) do
      local wins = app:allWindows()
      for _, win in ipairs(wins) do
        layout.func(win)
      end
    end
  end
end

This.cycleScreen = function()
  if This.fw() == nil then
    return
  end

  -- Create a sorted list of all windows in the current screen, including the currently focused one
  local windows = This.fw():otherWindowsSameScreen()
  table.insert(windows, This.fw())
  table.sort(windows, function(a, b) return a:title() < b:title() end)

  -- Create a new list that doesn't contain windows with no title (which is probably Finder, I guess?)
  -- And also make sure that the first item is repeated at the end, for easy roll-over
  local eligible = {}
  local first = nil
  for _, win in ipairs(windows) do
    if win:title() ~= '' then
      table.insert(eligible, win)
      if first == nil then
        first = win
      end
    end
  end
  table.insert(eligible, first)

  -- Find the position of the focused window in the list of eligible windows.
  local pos = 0
  local current = This.fw():title()
  for i, win in ipairs(eligible) do
    if win:title() == current then
      pos = i
      break  -- otherwise we might match the final occurrence
    end
  end

  -- Focus the next window
  eligible[pos + 1]:focus()
end

This.leftPressed = function()
  pressed.left = true
  if pressed.down then
    windowMoveBottomLeft()
  elseif pressed.up then
    windowMoveTopLeft()
  else
    windowMoveLeft()
  end
end

This.downPressed = function()
  pressed.down = true
  if pressed.left then
    windowMoveBottomLeft()
  elseif pressed.right then
    windowMoveBottomRight()
  else
    windowMoveDown()
  end
end

This.upPressed = function()
  pressed.up = true
  if pressed.left then
    windowMoveTopLeft()
  elseif pressed.right then
    windowMoveTopRight()
  else
    windowMoveUp()
  end
end

This.rightPressed = function()
  pressed.right = true
  if pressed.down then
    windowMoveBottomRight()
  elseif pressed.up then
    windowMoveTopRight()
  else
    windowMoveRight()
  end
end

This.leftReleased = function()
  pressed.left = false
end

This.downReleased = function()
  pressed.down = false
end

This.upReleased = function()
  pressed.up = false
end

This.rightReleased = function()
  pressed.right = false
end

return This

