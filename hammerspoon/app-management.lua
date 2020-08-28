local This = {}

-- Quickly move to and from a specific app
-- (Thanks Teije)
local previousApp = ""

local launchOrFocus = function(bundleID, launchIfNotRunning)
  if launchIfNotRunning then
    hs.application.launchOrFocusByBundleID(bundleID)
  else
    hs.application.applicationsForBundleID(bundleID)[1]:activate()
  end
end

local switch = function(bundleID, launchIfNotRunning)
  local focusedWindow = hs.window.focusedWindow()

  if focusedWindow == nil then
    launchOrFocus(bundleID, launchIfNotRunning)
  elseif focusedWindow:application():bundleID() == bundleID then
    if previousApp == nil then
      hs.window.switcher.nextWindow()
    else
      previousApp:activate()
    end
  else
    previousApp = focusedWindow:application()
    launchOrFocus(bundleID, launchIfNotRunning)
  end
end

This.switchToAndFromApp = function(bundleID)
  switch(bundleID, true)
end

This.switchToAndFromAppNoLaunch = function(bundleID)
  switch(bundleID, false)
end

return This

