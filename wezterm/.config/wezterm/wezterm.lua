local wezterm = require('wezterm')
local act = wezterm.action

local config = wezterm.config_builder()

local monolisa = function(bold)
    local monolisa = {}
    monolisa.family = 'monolisa'
    monolisa.harfbuzz_features = { 'calt', '-liga', 'ss10', 'ss11', 'ss14' }
    if bold then
        monolisa.weight = 'Bold'
    end
    return wezterm.font(monolisa)
end

config = {
    -- Appearance
    adjust_window_size_when_changing_font_size = false,
    hide_tab_bar_if_only_one_tab = true,
    window_decorations = 'NONE',
    window_frame = {
        font = monolisa(true)
    },
    font = monolisa(),

    -- Key bindings
    disable_default_key_bindings = true,
    keys = {
        { key = 'Enter',      mods = 'ALT',       action = act.SplitPane { direction = 'Right' } },
        { key = 'w',          mods = 'ALT',       action = act.CloseCurrentTab { confirm = true } },
        { key = 'h',          mods = 'ALT',       action = act.ActivatePaneDirection('Left') },
        { key = 'l',          mods = 'ALT',       action = act.ActivatePaneDirection('Right') },
        { key = '[',          mods = 'ALT',       action = act.ActivatePaneDirection('Left') },
        { key = ']',          mods = 'ALT',       action = act.ActivatePaneDirection('Right') },
        { key = 'r',          mods = 'ALT',       action = act.QuickSelect },
        { key = 'Enter',      mods = 'ALT|SHIFT', action = act.SpawnCommandInNewTab { cwd = '~' } },
        { key = 'h',          mods = 'ALT|SHIFT', action = act.ActivateTabRelative(-1) },
        { key = 'l',          mods = 'ALT|SHIFT', action = act.ActivateTabRelative(1) },
        { key = '{',          mods = 'ALT|SHIFT', action = act.ActivateTabRelative(-1) }, -- Alt+Shift+[
        { key = '}',          mods = 'ALT|SHIFT', action = act.ActivateTabRelative(1) },  -- Alt+Shift+]
        { key = 'LeftArrow',  mods = 'ALT|SHIFT', action = act.MoveTabRelative(-1) },
        { key = 'RightArrow', mods = 'ALT|SHIFT', action = act.MoveTabRelative(1) },
        { key = 'z',          mods = 'ALT',       action = act.TogglePaneZoomState },
        { key = 'c',          mods = 'ALT',       action = act.CopyTo('Clipboard') },
        { key = 'v',          mods = 'ALT',       action = act.PasteFrom('Clipboard') },
        { key = '=',          mods = 'ALT',       action = act.IncreaseFontSize },
        { key = '-',          mods = 'ALT',       action = act.DecreaseFontSize },
        { key = 'd',          mods = 'ALT',       action = act.ShowDebugOverlay },
        { key = 'UpArrow',    mods = 'ALT',       action = act.ScrollByPage(-1) },
        { key = 'DownArrow',  mods = 'ALT',       action = act.ScrollByPage(1) },
        { key = 'e',          mods = 'ALT',       action = act.CharSelect }
    },

    -- Colors
    colors = {
        foreground = '#b9b9b9',
        background = '#181818',
        cursor_bg = '#dedede',
        cursor_border = '#dedede',
        cursor_fg = '#181818',
        selection_bg = '#777777',
        selection_fg = 'none',
        tab_bar = {
            background = '#3b3b3b',
            active_tab = {
                bg_color = '#83c746',
                fg_color = '#dedede',
            },
            inactive_tab = {
                bg_color = '#777777',
                fg_color = '#dedede',
            },
        },
        ansi = {
            '#252525', '#ed4a46', '#70b433', '#dbb32d', '#368aeb', '#eb6eb7', '#3fc5b7', '#777777',
        },
        brights = {
            '#3b3b3b', '#ff5e56', '#83c746', '#efc541', '#4f9cfe', '#ff81ca', '#56d8c9', '#dedede',
        }
    }
}

return config
