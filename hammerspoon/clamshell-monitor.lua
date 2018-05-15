local This = {}
local clamshellTimer

local detectClamshell = function()
  local screens = hs.screen.allScreens()
  local macbookscreen = false
  local size = 0
  for i,scr in ipairs(screens) do
    size = size + i
    if scr:name() == "Color LCD" then
      macbookscreen = true
    end
  end
  if (not macbookscreen) and (size > 1) then
    hs.alert.show("WARNING: in clamshell mode")
  end
end

This.activate = function()
  if clamshellTimer and clamshellTimer:running() then
    clamshellTimer:stop()
  end
  clamshellTimer = hs.timer.doEvery(15, detectClamshell)
end

return This
