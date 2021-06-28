local This = {}

local util = require('util')

local autostart_scripts = {
  util.script('display.sh'),
  util.change_background
}

local autostart_apps = {
  { 'nm-applet', '' },
  { 'blueman-applet', '' },
  { 'numlockx', 'on' },
  { 'picom', '-b -f' },
  { 'dropbox', 'start' },
  { 'xautolock', '-time 2 -locker "' .. util.script('lock.sh') .. '"' },
  { 'rambox', '' },
  { 'teams', '' },
  { 'mailspring', '' },
  { 'firefox', '' }
}

function This.setup()
  for _, cmd in ipairs(autostart_scripts) do
    util.run(cmd)
  end
  for _, cmd in ipairs(autostart_apps) do
    util.run_once(cmd[1], cmd[2])
  end
end

return This
