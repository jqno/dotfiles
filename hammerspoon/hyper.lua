local This = {}
local hyperMode = {}

-- Note: we need two hotkeys for Hyper mode. One to invoke it (`hotKey`)
-- and one to keep track of whether the mode is still active (`toggleKey`).
-- Using the same key for both functions makes the mode extremely jittery.
-- (I.e. it gets turned on and off at almost every keypress.)

local enterHyperMode = function()
  hyperMode.triggered = false
  hyperMode:enter()
end

local exitHyperMode = function()
  hyperMode:exit()
end

This.bindKey = function(modifiers, key, pressedfn, releasedfn)
  hyperMode:bind(modifiers, key, function()
    pressedfn()
    hyperMode.triggered = true
  end, releasedfn)
end

This.activate = function(hotKey, toggleKey)
  hyperMode = hs.hotkey.modal.new({}, toggleKey)
  hs.hotkey.bind({}, hotKey, enterHyperMode, exitHyperMode)
  hs.hotkey.bind({"shift"}, hotKey, enterHyperMode, exitHyperMode)
  hs.hotkey.bind({"ctrl"}, hotKey, enterHyperMode, exitHyperMode)
  hs.hotkey.bind({"ctrl", "shift"}, hotKey, enterHyperMode, exitHyperMode)
  hs.hotkey.bind({"cmd"}, hotKey, enterHyperMode, exitHyperMode)
  hs.hotkey.bind({"cmd", "shift"}, hotKey, enterHyperMode, exitHyperMode)
  hs.hotkey.bind({"cmd", "ctrl"}, hotKey, enterHyperMode, exitHyperMode)
  hs.hotkey.bind({"cmd", "ctrl", "shift"}, hotKey, enterHyperMode, exitHyperMode)
  hs.hotkey.bind({"alt"}, hotKey, enterHyperMode, exitHyperMode)
  hs.hotkey.bind({"alt", "shift"}, hotKey, enterHyperMode, exitHyperMode)
  hs.hotkey.bind({"alt", "ctrl"}, hotKey, enterHyperMode, exitHyperMode)
  hs.hotkey.bind({"alt", "ctrl", "shift"}, hotKey, enterHyperMode, exitHyperMode)
  hs.hotkey.bind({"alt", "cmd"}, hotKey, enterHyperMode, exitHyperMode)
  hs.hotkey.bind({"alt", "cmd", "shift"}, hotKey, enterHyperMode, exitHyperMode)
  hs.hotkey.bind({"alt", "cmd", "ctrl"}, hotKey, enterHyperMode, exitHyperMode)
  hs.hotkey.bind({"alt", "cmd", "shift", "ctrl"}, hotKey, enterHyperMode, exitHyperMode)
end

return This

