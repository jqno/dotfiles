local This = {}

This.terminal = 'kitty'
This.editor = This.terminal .. ' -e ' .. (os.getenv('EDITOR') or 'editor')

This.main = {
  rambox = {
    executable = 'Rambox',
    class = 'Rambox',
    hotkey = '1'
  },
  teams = {
    executable = 'teams',
    class = 'Microsoft Teams - Preview',
    hotkey = '2'
  },
  chromium = {
    executable = 'chromium',
    class = 'Chromium',
    hotkey = '3'
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
