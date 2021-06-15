local This = {}

This.location_scripts = '~/.config/awesome/scripts/'
This.location_wallpapers = '~/Dropbox/wallpapers/'

function This.script(name)
  return This.location_scripts .. name
end

return This
