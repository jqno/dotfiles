local This = {}
local caffeine = hs.menubar.new()

-- Use PDF files because they're vector-based and will scale well on Future Hardware™.

local setCaffeineDisplay = function(state)
  if state then
    caffeine:setIcon("caffeine-on.pdf")
  else
    caffeine:setIcon("caffeine-off.pdf")
  end
end

local caffeineClicked = function()
  setCaffeineDisplay(hs.caffeinate.toggle("displayIdle"))
end

function This.activate()
  if caffeine then
    caffeine:setClickCallback(caffeineClicked)
    setCaffeineDisplay(hs.caffeinate.get("displayIdle"))
  end
end

return This

