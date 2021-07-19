# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the 'Software'), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

import os
import subprocess

from typing import List  # noqa: F401

from libqtile import bar, hook, layout, qtile, widget
from libqtile.config import Click, Drag, Group, Key, KeyChord, Match, Screen
from libqtile.lazy import lazy

from Xlib import display as xdisplay

mod = 'mod4'
hyper = 'mod3'
terminal = 'kitty'

gap = 4
bar_height = 24

home = os.path.expanduser('~')
script_location = home + '/.config/qtile/scripts'

def find_or_run(wmclass, app=None):
    def __inner(qtile):
        for w in qtile.windows_map.values():
            if w.group and w.match(Match(wm_class = wmclass)):
                qtile.current_screen.set_group(w.group)
                w.group.focus(w)
                return

        if app is not None:
            qtile.cmd_spawn(app)
        
    return __inner

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
    Key([mod], 'o',
        lazy.layout.next(),
        desc='Move window focus to other window'),

    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
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

    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, 'control'], 'h',
        lazy.layout.grow_left(),
        desc='Grow window to the left'),
    Key([mod, 'control'], 'l',
        lazy.layout.grow_right(),
        desc='Grow window to the right'),
    Key([mod, 'control'], 'j',
        lazy.layout.grow_down(),
        desc='Grow window down'),
    Key([mod, 'control'], 'k',
        lazy.layout.grow_up(),
        desc='Grow window up'),
    Key([mod], 'n',
        lazy.layout.normalize(),
        desc='Reset all window sizes'),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, 'shift'], 'Return',
        lazy.layout.toggle_split(),
        desc='Toggle between split and unsplit sides of stack'),
    Key([mod], 'f',
        lazy.window.toggle_fullscreen(),
        desc='Makes current window fullscreen'),

    Key([mod], 'Left',
        lazy.screen.prev_group(),
        desc='Move to previous group'),
    Key([mod], 'Right',
        lazy.screen.next_group(),
        desc='Move to next group'),
    Key([mod], 'Tab',
        lazy.screen.toggle_group(),
        desc='Move to last visited group'),

    # Toggle between different layouts as defined below
    Key([mod], 'backslash',
        lazy.next_layout(),
        desc='Toggle between layouts'),
    Key([mod, 'shift'], 'q',
        lazy.window.kill(),
        desc='Kill focused window'),

    Key([mod], 'Return',
        lazy.spawn(terminal),
        desc='Launch terminal'),
    Key([mod], 'space',
        lazy.spawn('rofi -modi drun -show drun'),
        desc='Spawn an app using rofi'),
    Key([mod, 'control'], 'r',
        lazy.restart(),
        desc='Restart Qtile'),
    Key([mod], 'BackSpace',
        lazy.spawn(script_location + '/lock.sh'),
        desc='Lock screen'),

    KeyChord([mod, 'shift'], 'BackSpace', [
        Key([], 'l',
            lazy.shutdown(),
            desc='Log out'),
        Key([], 'r',
            lazy.spawn('sudo reboot -f'),
            desc='Reboot'),
        Key([], 's',
            lazy.spawn('shutdown now'),
            desc='Shutdown')
    ], mode='Exit: Log out | Reboot | Shut down'),

    # System keybindings
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
        lazy.spawn('pactl set-sink-mute @DEFAULT_SINK@ toggle'), desc='Mute audio'),
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

    Key([hyper], 'c',
        lazy.function(find_or_run('Chromium', 'chromium')),
        desc='focus Chromium'),
    Key([hyper], 'e',
        lazy.function(find_or_run('Org.gnome.Characters', 'gnome-characters')),
        desc='focus Characters'),
    Key([hyper], 'f',
        lazy.function(find_or_run('Org.gnome.Nautilus', 'nautilus')),
        desc='focus Nautilus'),
    Key([hyper], 'm',
        lazy.function(find_or_run('Mailspring', 'mailspring')),
        desc='focus Mailspring'),
    Key([hyper], 'r',
        lazy.function(find_or_run('Rambox', 'rambox')),
        desc='focus Rambox'),
    Key([hyper], 's',
        lazy.function(find_or_run('Spotify', 'spotify')),
        desc='focus Spotify'),
    Key([hyper], 't',
        lazy.function(find_or_run('Microsoft Teams - Preview')),
        desc='focus Microsoft Teams'),
    Key([hyper], 'w',
        lazy.function(find_or_run('Firefox', 'firefox')),
        desc='focus Firefox'),
    Key([hyper], 'backslash',
        lazy.function(find_or_run('KeePassXC', 'keepassxc')),
        desc='focus KeePassXC'),
]

colors = {
    'panel': '#3b4252',
    'inactive': '#4c566a',
    'text': '#eceff4',
    'primary': '#88c0d0',
    'secondary': '#5e81ac',
    'error': '#bf616a',
    'warning': '#ebcb8b',
    'success': '#a3be8c'
}

group_descriptions = [
    ('DEV₁',  '1', {'layout': 'columns'}),
    ('DEV₂',  '2', {'layout': 'columns'}),
    ('DEV₃',  '3', {'layout': 'columns'}),
    ('COMM₄', '4', {'layout': 'stack', 'matches': [Match(wm_class='Rambox'), Match(wm_class='Mailspring'), Match(wm_class='Microsoft Teams - Preview')]}),
    ('WWW₅',  '5', {'layout': 'columns', 'matches': [Match(wm_class='Firefox')]}),
    ('MUS₆',  '6', {'layout': 'stack', 'matches': [Match(wm_class='Spotify'), Match(wm_class='Chromium')]}),
    ('ETC₇',  '7', {'layout': 'columns'}),
    ('ETC₈',  '8', {'layout': 'columns'}),
    ('ETC₉',  '9', {'layout': 'columns'}),
    ('ETC₀',  '0', {'layout': 'columns'}),
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
            lazy.window.togroup(name, switch_group=True),
            desc='Switch to & move focused window to group {}'.format(name)),
    ])

layout_theme = {
    'margin': gap,
    'border_width': 2,
    'border_focus': colors['primary'],
    'border_normal': colors['inactive']
}

layouts = [
    layout.Columns(
        grow_amount = 5,
        border_on_single = True,
        **layout_theme
    ),
    layout.Stack(
        num_stacks = 1,
        **layout_theme
    ),
    layout.Floating(
        **layout_theme
    )
]

widget_defaults = dict(
    font='sans',
    fontsize=12,
    padding=3,
    foreground=colors['text']
)
extension_defaults = widget_defaults.copy()


def base_bar():
    return [
        widget.Spacer(gap),
        widget.CurrentScreen(
            active_text='',
            active_color=colors['primary'],
            inactive_text='',
            inactive_color=colors['inactive']
        ),
        widget.CurrentLayoutIcon(
            scale=0.6
        ),
        widget.GroupBox(
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
        widget.Chord(),
        widget.Prompt(),
        widget.WindowName(
            fmt=''
        ),
    ]

def short_bar(): 
    return base_bar() + [
        widget.Clock(
            format='%d %b %Y %H:%M'
        ),
        widget.Spacer(gap),
    ]

def full_bar():
    return base_bar() + [
        widget.Systray(
            icon_size=16
        ),
        widget.Volume(
            emoji=True
        ),
        widget.TextBox(
            text='|',
            fontsize=32,
            foreground=colors['inactive']
        ),
        widget.CheckUpdates(
            distro='Ubuntu',
            display_format=' {updates}',
            no_update_string='',
            restart_indicator='',
            mouse_callbacks = { 'Button1': lambda: qtile.cmd_spawn('update-manager') },
            color_no_updates=colors['inactive'],
            color_have_updates=colors['warning'],
            foreground=colors['success']
        ),
        widget.TextBox(
            text='|',
            fontsize=32,
            foreground=colors['inactive']
        ),
        widget.Battery(
            charge_char='↑',
            discharge_char='↓',
            empty_char='ø',
            full_char='',
            notify_below=0.15,
            show_short_text = False,
            format='  {char} {percent:2.0%}'
        ),
        widget.TextBox(
            text='|',
            fontsize=32,
            foreground=colors['inactive']
        ),
        widget.Clock(
            format='%d %b %Y %H:%M'
        ),
        widget.Spacer(gap),
    ]

def create_bar(widgets):
    return bar.Bar(widgets, bar_height, margin = gap, background = colors['panel'])

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
    except:  
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

# Drag floating layouts.
mouse = [
    Drag([mod], 'Button1', lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod, 'shift'], 'Button1', lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], 'Button1', lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    *layout.Floating.default_float_rules,
    Match(wm_class='Arandr'),
    Match(wm_class='Blueman-manager'),
    Match(wm_class='Org.gnome.Characters'),
    Match(wm_class='ssh-askpass'),  # ssh-askpass
    Match(title='Event Tester'), # xev
    Match(title='pinentry'),  # GPG key password entry
])
auto_fullscreen = True
focus_on_window_activation = 'smart'
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

@hook.subscribe.startup_once
def autostart():
    subprocess.call([script_location + '/autostart.sh'])

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = 'LG3D'
