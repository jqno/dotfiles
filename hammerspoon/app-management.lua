local This = {}

-- Quickly move to and from a specific app
-- (Thanks Teije)
local previousApp = ""

local focusApp = function(bundleID)
  hs.application.launchOrFocusByBundleID(bundleID)
  if hs.window.focusedWindow() == nil then
    if bundleID == "com.googlecode.iterm2" then
      hs.applescript.applescript([[
        tell application "iTerm"
          activate
        end tell
      ]])
    end
  end
end

This.switchToAndFromApp = function(bundleID)
  local focusedWindow = hs.window.focusedWindow()

  if focusedWindow == nil then
    focusApp(bundleID)
  elseif focusedWindow:application():bundleID() == bundleID then
    if previousApp == nil then
      hs.window.switcher.nextWindow()
    else
      previousApp:activate()
    end
  else
    previousApp = focusedWindow:application()
    focusApp(bundleID)
  end
end

-- De simpelere versie van Teijes script die net iets anders werkt, voor historische doeleinden hier bewaard:
-- local previousOpenedApp = ""
-- function switchToApp(bundleID)
--   local focusedApp = hs.window.focusedWindow():application():bundleID()
--
--   if focusedApp ~= bundleID then
--     previousOpenedApp = focusedApp
--     hs.application.launchOrFocusByBundleID(bundleID)
--   elseif previousOpenedApp then
--     hs.application.launchOrFocusByBundleID(previousOpenedApp)
--   end
-- end



-- Open new windows

This.newItermWindow = function()
  hs.applescript.applescript([[
    tell application "iTerm"
      create window with default profile
    end tell
  ]])
end

return This

