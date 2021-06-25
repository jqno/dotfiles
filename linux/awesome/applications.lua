local This = {}

local tags = require('screens').special_tag_names

This.main = {
  chromium = {
    executable = 'chromium',
    class = 'Chromium',
    hotkey = 'c',
    tag = tags.chat
  },
  files = {
    executable = 'nautilus',
    class = 'Org.gnome.Nautilus',
    hotkey = 'f'
  },
  keepass = {
    executable = 'keepassxc',
    class = 'KeePassXC',
    hotkey = '\\'
  },
  mail = {
    executable = 'mailspring',
    class = 'Mailspring',
    hotkey = 'm',
    tag = tags.chat
  },
  plex = {
    executable = os.getenv('HOME') .. '/bin/Plex_Media_Player_2.58.1-ae73e074_x64.AppImage',
    class = 'plexmediaplayer',
    hotkey = 'p',
    tag = tags.music
  },
  rambox = {
    executable = 'rambox',
    class = 'Rambox',
    hotkey = 'r',
    tag = tags.chat
  },
  spotify = {
    executable = 'spotify',
    class = 'Spotify',
    hotkey = 's',
    tag = tags.music
  },
  teams = {
    executable = 'teams',
    class = 'Microsoft Teams - Preview',
    hotkey = 't',
    tag = tags.chat
  },
  web = {
    executable = 'firefox',
    class = 'Firefox',
    hotkey = 'w',
    tag = tags.browse
  }
}

return This
