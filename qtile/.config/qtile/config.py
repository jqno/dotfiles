import os
import subprocess
from libqtile import bar, hook, layout, widget
from libqtile.config import Click, Drag, Group, Key, KeyChord, Match, Screen
from libqtile.lazy import lazy
from Xlib import display as xdisplay
import arcobattery
import analogclock


# CONSTANTS #

mod = 'mod4'
hyper = 'mod3'
terminal = 'kitty'

gap = 4
widegap = gap * 3
bar_height = 32

home = os.path.expanduser('~')
script_location = home + '/.config/qtile/scripts'

colors = {
    'panel': '#3b3b3b',
    'inactive': '#777777',
    'text': '#dedede',
    'primary': '#83c746',
    'secondary': '#4f9cfe',
    'error': '#ff5e56',
    'warning': '#ff81ca',
    'success': '#efc541'
}


# HELPER FUNCTIONS #

def find_or_run_app(wmclass, app=None):
    def __inner(qtile):
        for w in qtile.windows_map.values():
            if w.group and w.match(Match(wm_class=wmclass)):
                qtile.current_screen.set_group(w.group)
                w.group.focus(w)
                return

        if app is not None:
            qtile.cmd_spawn(app)

    return __inner


def move_window_to_other_screen():
    def __inner(qtile):
        scr = qtile.screens.index(qtile.current_screen)
        grp = qtile.screens[1 - scr].group.name
        qtile.current_window.togroup(grp)
        qtile.focus_screen(1 - scr)

    return __inner


def focus_other_screen():
    def __inner(qtile):
        scr = qtile.screens.index(qtile.current_screen)
        qtile.focus_screen(1 - scr)

    return __inner


def switch_screens():
    def __inner(qtile):
        scr = qtile.screens.index(qtile.current_screen)
        grp = qtile.screens[1 - scr].group
        qtile.current_screen.set_group(grp)

    return __inner


# KEYS #

keys = [
    # Switch between windows
    Key([mod], 'h',
        lazy.layout.left(),
        desc='Move focus to left'),
    Key([mod], 'l',
        lazy.layout.right(),
        desc='Move focus to right'),
    Key([mod], 'j',
        lazy.layout.down(),
        desc='Move focus down'),
    Key([mod], 'k',
        lazy.layout.up(),
        desc='Move focus up'),
    Key([mod], 'Tab',
        lazy.layout.next(),
        desc='Move window focus to other window'),

    # Move windows between within layout.
    Key([mod, 'shift'], 'h',
        lazy.layout.shuffle_left(),
        desc='Move window to the left'),
    Key([mod, 'shift'], 'l',
        lazy.layout.shuffle_right(),
        desc='Move window to the right'),
    Key([mod, 'shift'], 'j',
        lazy.layout.shuffle_down(),
        desc='Move window down'),
    Key([mod, 'shift'], 'k',
        lazy.layout.shuffle_up(),
        desc='Move window up'),
    Key([mod, 'shift'], 'o',
        lazy.function(move_window_to_other_screen()),
        desc='Move window to other screen'),

    # Resize windows
    Key([mod], 'minus',
        lazy.layout.shrink(),
        desc='Shrink current window'),
    Key([mod], 'equal',
        lazy.layout.grow(),
        desc='Grow current window'),
    Key([mod, 'control'], 'n',
        lazy.layout.normalize(),
        desc='Reset all window sizes'),
    Key([mod], 'f',
        lazy.window.toggle_fullscreen(),
        desc='Makes current window fullscreen'),
    Key([mod], 't',
        lazy.window.toggle_floating(),
        desc='Toggle floating'),

    # Switch between groups
    Key([mod], 'Left',
        lazy.screen.prev_group(),
        desc='Move to previous group'),
    Key([mod], 'Right',
        lazy.screen.next_group(),
        desc='Move to next group'),
    Key([mod, 'shift'], 'Tab',
        lazy.screen.toggle_group(),
        desc='Move to last visited group'),

    # Switch between screens
    Key([mod], 'o',
        lazy.function(focus_other_screen()),
        desc='Move focus to other screen'),
    Key([mod], 'grave',
        lazy.function(switch_screens()),
        desc='Swap screens'),

    # Toggle between different layouts
    Key([mod], 'Tab',
        lazy.next_layout(),
        desc='Toggle between layouts'),

    # Close and reload things
    Key([mod, 'shift'], 'q',
        lazy.window.kill(),
        desc='Kill focused window'),
    Key([mod, 'control'], 'r',
        lazy.restart(),
        desc='Restart Qtile'),
    Key([mod], 'BackSpace',
        lazy.spawn(script_location + '/lock.sh'),
        desc='Lock screen'),
    Key([mod, 'shift'], 'BackSpace',
        lazy.spawn('arcolinux-logout'),
        desc='Logout menu'),

    # System keybindings
    KeyChord([mod], 'd', [
        Key([], 'm',
            lazy.spawn(home + '/scripts/manage_displays.sh mirror'),
            desc='Mirror displays'),
        Key([], 'l',
            lazy.spawn(home + '/scripts/manage_displays.sh left'),
            desc='Put external display to the left'),
        Key([], 'r',
            lazy.spawn(home + '/scripts/manage_displays.sh right'),
            desc='Put external display to the right')
    ], mode='Configure displays: [m]irror, [l]eft, [r]ight'),
    Key([mod], 'b',
        lazy.spawn(script_location + '/background.sh'),
        desc='Set a random background'),
    Key([mod, 'shift'], 'b',
        lazy.spawn(script_location + '/background.sh known'),
        desc='Set a known background'),
    Key([mod], 'Print',
        lazy.spawn(script_location + '/scrot.sh window'),
        desc='Take screenshot of window'),
    Key([], 'Print',
        lazy.spawn(script_location + '/scrot.sh'),
        desc='Take screenshot'),
    Key([], 'XF86AudioRaiseVolume',
        lazy.spawn('pactl set-sink-volume @DEFAULT_SINK@ +5%'),
        desc='Raise volume'),
    Key([], 'XF86AudioLowerVolume',
        lazy.spawn('pactl set-sink-volume @DEFAULT_SINK@ -5%'),
        desc='Lower volume'),
    Key([], 'XF86AudioMute',
        lazy.spawn('pactl set-sink-mute @DEFAULT_SINK@ toggle'),
        desc='Mute audio'),
    Key([], 'XF86AudioPlay',
        lazy.spawn('playerctl play-pause'),
        desc='Play audio'),
    Key([], 'XF86AudioPause',
        lazy.spawn('playerctl play-pause'),
        desc='Pause audio'),
    Key([], 'XF86AudioNext',
        lazy.spawn('playerctl next'),
        desc='Next track'),
    Key([], 'XF86AudioPrev',
        lazy.spawn('playerctl previous'),
        desc='Previous track'),
    Key([], 'XF86MonBrightnessUp',
        lazy.spawn('sudo brightnessctl set 10%+'),
        desc='Increase brightness'),
    Key([], 'XF86MonBrightnessDown',
        lazy.spawn('sudo brightnessctl set 10%-'),
        desc='Decrease brightness'),

    # Launching
    Key([mod], 'Return',
        lazy.spawn(terminal),
        desc='Launch terminal'),
    Key([mod], 'space',
        lazy.spawn('rofi -modi drun -show drun'),
        desc='Spawn an app using rofi'),
    Key([hyper], 'space',
        lazy.spawn('rofi -show window'),
        desc='Switch to a window using rofi'),
    Key(['mod1'], 'space',
        lazy.spawn('rofimoji'),
        desc='Emoji picker'),

    # Managing apps
    Key([hyper], 'c',
        lazy.function(find_or_run_app('Google-chrome', 'google-chrome-stable')),
        desc='focus Chromium'),
    Key([hyper], 'f',
        lazy.function(find_or_run_app('Org.gnome.Nautilus', 'nautilus')),
        desc='focus Nautilus'),
    Key([hyper], 'm',
        lazy.function(find_or_run_app('Mailspring', 'mailspring')),
        desc='focus Mailspring'),
    Key([hyper], 'r',
        lazy.function(find_or_run_app('Rambox', 'rambox')),
        desc='focus Rambox'),
    Key([hyper], 's',
        lazy.function(find_or_run_app('Spotify', 'spotify')),
        desc='focus Spotify'),
    Key([hyper], 't',
        lazy.function(find_or_run_app('Microsoft Teams - Preview')),
        desc='focus Microsoft Teams'),
    Key([hyper], 'w',
        lazy.function(find_or_run_app('firefox', 'firefox')),
        desc='focus Firefox'),
    Key([hyper], 'z',
        lazy.function(find_or_run_app('zoom')),
        desc='focus Zoom'),
    Key([hyper], 'backslash',
        lazy.function(find_or_run_app('KeePassXC', 'keepassxc')),
        desc='focus KeePassXC'),
]


# GROUPS #

group_descriptions = [
    ('', '1', {'layout': 'monadtall'}),
    ('', '2', {'layout': 'monadtall'}),
    ('', '3', {'layout': 'monadtall'}),
    ('', '4', {'layout': 'monadtall'}),
    ('', '5', {'layout': 'monadtall'}),
    ('', '6', {'layout': 'monadtall'}),
    ('', '7', {'layout': 'monadtall', 'matches':
        [Match(wm_class='zoom'), Match(wm_class='obs')]}),
    ('', '8', {'layout': 'stack', 'matches':
        [Match(wm_class='Spotify'), Match(wm_class='Chromium')]}),
    ('', '9', {'layout': 'monadtall', 'matches':
        [Match(wm_class='firefox')]}),
    ('', '0', {'layout': 'stack', 'matches':
        [Match(wm_class='Rambox'), Match(wm_class='Mailspring'), Match(wm_class='Microsoft Teams - Preview')]}),
]
groups = [Group(name, **kwargs) for name, _, kwargs in group_descriptions]

for (name, key, _) in group_descriptions:
    keys.extend([
        # (super or hyper) + letter of group = switch to group
        Key([mod], key,
            lazy.group[name].toscreen(),
            desc='Switch to group {}'.format(name)),
        Key([hyper], key,
            lazy.group[name].toscreen(),
            desc='Switch to group {}'.format(name)),

        # super + shift + letter of group = switch to & move focused window to group
        Key([mod, 'shift'], key,
            lazy.window.togroup(name),
            desc='Switch to & move focused window to group {}'.format(name)),
    ])


# LAYOUTS #

layout_theme = {
    'margin': gap,
    'border_width': 2,
    'border_focus': colors['primary'],
    'border_normal': colors['inactive']
}

layouts = [
    layout.MonadTall(
        grow_amount=5,
        ratio=0.65,
        border_on_single=True,
        **layout_theme
    ),
    layout.Stack(
        num_stacks=1,
        **layout_theme
    ),
    layout.MonadWide(
        grow_amount=5,
        ratio=0.65,
        border_on_single=True,
        **layout_theme
    ),
    layout.Floating(
        **layout_theme
    )
]


# BAR #

widget_defaults = dict(
    font='sans',
    fontsize=12,
    padding=3,
    foreground=colors['text']
)


def base_bar():
    return [
        widget.Spacer(gap * 2),
        widget.CurrentScreen(
            fontsize=16,
            active_text='●',
            active_color=colors['primary'],
            inactive_text='○',
            inactive_color=colors['inactive']
        ),
        widget.CurrentLayoutIcon(
            scale=0.6
        ),
        widget.Sep(
            foreground=colors['inactive'],
            padding=widegap,
            linewidth=2,
            size_percent=100
        ),
        widget.GroupBox(
            font='FontAwesome',
            fontsize=15,
            disable_drag=True,
            highlight_method='line',
            highlight_color=[colors['panel'], colors['secondary']],
            hide_unused=True,
            this_screen_border=colors['secondary'],
            this_current_screen_border=colors['primary'],
            other_screen_border=colors['inactive'],
            other_current_screen_border=colors['inactive'],
            urgent_alert_method='line',
            urgent_border=colors['error']
        ),
        widget.Sep(
            foreground=colors['inactive'],
            padding=widegap,
            linewidth=2,
            size_percent=100
        ),
        widget.Prompt(),
        widget.Chord(),
        widget.Spacer(),
    ]


def short_bar():
    return base_bar() + [
        widget.Sep(
            foreground=colors['inactive'],
            padding=widegap,
            linewidth=2,
            size_percent=100
        ),
        analogclock.AnalogClock(
            fontsize=22,
        ),
        widget.Spacer(gap * 2),
    ]


def full_bar():
    return base_bar() + [
        widget.Sep(
            foreground=colors['inactive'],
            padding=widegap,
            linewidth=2,
            size_percent=100
        ),
        widget.Systray(
            icon_size=16
        ),
        arcobattery.BatteryIcon(
            padding=0,
            scale=0.65,
            y_poss=1,
            theme_path=home + '/.config/qtile/icons/resized_arco_battery_icons',
            update_interval=5
        ),
        analogclock.AnalogClock(
            fontsize=22,
        ),
        widget.Spacer(gap * 2),
    ]


def create_bar(widgets):
    return bar.Bar(widgets, bar_height, margin=gap, background=colors['panel'])


# SCREENS #

def get_number_of_monitors():
    num_monitors = 0
    try:
        display = xdisplay.Display()
        screen = display.screen()
        resources = screen.root.xrandr_get_screen_resources()

        for output in resources.outputs:
            monitor = display.xrandr_get_output_info(output, resources.config_timestamp)
            preferred = False
            if hasattr(monitor, "preferred"):
                preferred = monitor.preferred
            elif hasattr(monitor, "num_preferred"):
                preferred = monitor.num_preferred
            if preferred:
                num_monitors += 1
    except Exception:
        return 1
    else:
        return num_monitors


def create_screen(widgets):
    return Screen(
        top=create_bar(widgets)
    )


screens = [create_screen(full_bar())]
number_of_monitors = get_number_of_monitors()
if number_of_monitors > 1:
    for m in range(number_of_monitors - 1):
        screens.append(create_screen(short_bar()))


# FLOATING LAYOUT #

mouse = [
    Drag([mod], 'Button1',
        lazy.window.set_position_floating(),
        start=lazy.window.get_position()),
    Drag([mod, 'shift'], 'Button1',
        lazy.window.set_size_floating(),
        start=lazy.window.get_size()),
    Click([mod], 'Button1',
        lazy.window.bring_to_front())
]

floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    *layout.Floating.default_float_rules,
    Match(wm_class='Arandr'),
    Match(wm_class='Blueman-manager'),
    Match(wm_class='Org.gnome.Characters'),
    Match(wm_class='ssh-askpass'),  # ssh-askpass
    Match(title='Event Tester'),  # xev
    Match(title='pinentry'),  # GPG key password entry
])


# OPTIONS #

follow_mouse_focus = True
bring_front_click = True
cursor_warp = False
auto_fullscreen = True
focus_on_window_activation = 'smart'
reconfigure_screens = True
auto_minimize = True
wmname = 'LG3D'


# HOOKS #

@hook.subscribe.startup_once
def autostart():
    subprocess.call([script_location + '/autostart.sh'])
