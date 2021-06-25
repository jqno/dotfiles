local This = {}

This.main = {
  rambox = {
    executable = 'Rambox',
    class = 'Rambox',
    hotkey = 'r'
  },
  teams = {
    executable = 'teams',
    class = 'Microsoft Teams - Preview',
    hotkey = 't'
  },
  chromium = {
    executable = 'chromium',
    class = 'Chromium',
    hotkey = 'c'
  },
  keepass = {
    executable = 'keepassxc',
    class = 'KeePassXC',
    hotkey = '\\'
  },
  files = {
    executable = 'nautilus',
    class = 'Org.gnome.Nautilus',
    hotkey = 'f'
  },
  mail = {
    executable = 'mailspring',
    class = 'Mailspring',
    hotkey = 'm'
  },
  plex = {
    executable = os.getenv('HOME') .. '/bin/Plex_Media_Player_2.58.1-ae73e074_x64.AppImage',
    class = 'plexmediaplayer',
    hotkey = 'p'
  },
  spotify = {
    executable = 'spotify',
    class = 'Spotify',
    hotkey = 's'
  },
  web = {
    executable = 'firefox',
    class = 'Firefox',
    hotkey = 'w'
  }
}

return This
