import os
import subprocess

from libqtile.config import Key, Screen, Group, Match, Drag, Click
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook

mod = 'mod4'
alt = 'mod1'

keys = [
    Key([mod], 'k', lazy.layout.down()),  # Switch between windows in current stack pane
    Key([mod], 'j', lazy.layout.up()),

    Key([mod, 'control'], 'k', lazy.layout.shuffle_down()),  # Move windows up/down in current stack
    Key([mod, 'control'], 'j', lazy.layout.shuffle_up()),

    Key([mod], 'space', lazy.layout.next()),  # Switch window focus to other pane(s) of stack
    Key([mod, 'shift'], 'space', lazy.layout.rotate()),  # Swap panes of split stack

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with multiple stack panes
    Key([mod, 'shift'], 'Return', lazy.layout.toggle_split()),

    Key([mod], 'Return', lazy.spawn('konsole')),

    Key([alt], 'Tab', lazy.layout.next()),
    Key([alt, 'shift'], 'Tab', lazy.layout.previous()),

    Key([mod], 'Tab', lazy.nextlayout()),  # Toggle between different layouts as defined below

    Key([mod], 'w', lazy.window.kill()),

    Key([mod, 'control'], 'r', lazy.restart()),
    Key([mod, 'control'], 'q', lazy.shutdown()),
    Key([mod], 'r', lazy.spawncmd()),

    Key([mod], 'l', lazy.spawn('xscreensaver-command -l')),

    Key([mod], 'i', lazy.spawn('iceweasel')),

    Key([mod], "n", lazy.layout.normalize()),
    Key([mod], "m", lazy.layout.maximize()),
]

groups = [
    Group('1', matches=[Match(wm_class=['Iceweasel'])]),
    Group('2', matches=[Match(wm_class=['Skype'])], layout='tile'),
]
groups.extend([Group(str(i)) for i in range(3,7)])

for i in groups:
    keys.append(
        Key([mod], i.name, lazy.group[i.name].toscreen())
    )

    keys.append(
        Key([mod, 'shift'], i.name, lazy.window.togroup(i.name))
    )

layouts = [
    layout.Max(),
    layout.Stack(stacks=2),
    layout.Tile(ratio=0.75),
    layout.Matrix(),
]

widget_defaults = dict(
    font='Arial',
    fontsize=16,
    padding=3,
)

screens = [
    Screen(
        bottom=bar.Bar([
            widget.GroupBox(),
            widget.Prompt(),
            widget.WindowName(),
            widget.Systray(),
            widget.Battery(),
            widget.BatteryIcon(),
            widget.CurrentLayout(),
            widget.Clock(format='%Y-%m-%d %H:%M'),
        ], 30),
    ),
]

mouse = [
    Drag([mod], 'Button1', lazy.window.set_position_floating(),
         start=lazy.window.get_position()
    ),
    Drag([mod], 'Button3', lazy.window.set_size_floating(),
         start=lazy.window.get_size()
    ),
    Click([mod], 'Button2', lazy.window.bring_to_front()),
]

dgroup_key_binder = None
dgroup_add_rules = []
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_wrap = False
floating_layout = layout.Floating()
auto_fullscreen = True

@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart.sh'])
