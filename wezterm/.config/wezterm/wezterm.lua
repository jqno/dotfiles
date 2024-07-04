local wezterm = require('wezterm')
local act = wezterm.action
local nerdfonts = wezterm.nerdfonts

local plugin_smart_splits = wezterm.plugin.require('https://github.com/mrjones2014/smart-splits.nvim')
local plugin_logging = wezterm.plugin.require('https://github.com/sei40kr/wez-logging')

local config = wezterm.config_builder()

local constants = {
    tab_max_width = 32,
    tab_title = {
        left_circle = nerdfonts.ple_left_half_circle_thick,
        right_circle = nerdfonts.ple_right_half_circle_thick,
        color_bg = '#3b3b3b',
        color_active_bg = '#83c746',
        color_active_fg = '#dedede',
        color_copy_mode = '#368aeb',
        color_inactive_bg = '#777777',
        color_inactive_fg = '#dedede',
        apps = {
            ['apt'] = nerdfonts.dev_ubuntu,
            ['apt-get'] = nerdfonts.dev_ubuntu,
            ['bash'] = nerdfonts.cod_terminal,
            ['cargo'] = nerdfonts.dev_rust,
            ['curl'] = nerdfonts.mdi_progress_download,
            ['docker'] = nerdfonts.linux_docker,
            ['docker-compose'] = nerdfonts.linux_docker,
            ['gh'] = nerdfonts.dev_github_badge,
            ['git'] = nerdfonts.dev_git,
            ['go'] = nerdfonts.seti_go,
            ['java'] = nerdfonts.dev_java,
            ['k9s'] = nerdfonts.md_kubernetes,
            ['lazydocker'] = nerdfonts.linux_docker,
            ['make'] = nerdfonts.seti_makefile,
            ['node'] = nerdfonts.dev_nodejs_small,
            ['nvim'] = nerdfonts.custom_neovim,
            ['ruby'] = nerdfonts.cod_ruby,
            ['sudo'] = nerdfonts.fa_hashtag,
            ['tig'] = nerdfonts.dev_git,
            ['top'] = nerdfonts.mdi_chart_donut_variant,
            ['vim'] = nerdfonts.custom_vim,
            ['zsh'] = nerdfonts.cod_terminal
        }
    }
}

config = {
    -- Appearance
    window_background_opacity = 0.8,
    adjust_window_size_when_changing_font_size = false,
    hide_tab_bar_if_only_one_tab = true,
    show_new_tab_button_in_tab_bar = false,
    use_fancy_tab_bar = false,
    window_decorations = 'NONE',
    tab_max_width = constants.tab_max_width,
    inactive_pane_hsb = {
        saturation = 0.8,
        brightness = 0.5,
    },
    font = wezterm.font {
        family = 'monolisa',
        harfbuzz_features = { 'calt', '-liga', 'ss10', 'ss11', 'ss14' }
    },

    -- Key bindings
    disable_default_key_bindings = true,
    keys = {
        { key = 'Enter',      mods = 'ALT',       action = act.SplitPane { direction = 'Right' } },
        { key = 'w',          mods = 'ALT',       action = act.CloseCurrentTab { confirm = true } },
        { key = '[',          mods = 'ALT',       action = act.ActivatePaneDirection('Left') },
        { key = ']',          mods = 'ALT',       action = act.ActivatePaneDirection('Right') },
        { key = 'r',          mods = 'ALT',       action = act.QuickSelect },
        { key = 'Enter',      mods = 'ALT|SHIFT', action = act.SpawnCommandInNewTab { cwd = wezterm.home_dir } },
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
        { key = 'e',          mods = 'ALT',       action = act.CharSelect },
        { key = 'f',          mods = 'ALT',       action = plugin_logging.action.CaptureScrollback },
        { key = 'Backspace',  mods = 'ALT',       action = act.ActivateCopyMode }
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
        ansi = {
            '#252525', '#ed4a46', '#70b433', '#dbb32d', '#368aeb', '#eb6eb7', '#3fc5b7', '#777777',
        },
        brights = {
            '#3b3b3b', '#ff5e56', '#83c746', '#efc541', '#4f9cfe', '#ff81ca', '#56d8c9', '#dedede',
        },
        tab_bar = {
            background = constants.tab_title.color_bg
        }
    }
}

wezterm.on('format-tab-title', function(tab)
    local c = constants.tab_title

    -- Determine zoom state
    local zoomed = ''
    if tab.active_pane.is_zoomed then
        zoomed = nerdfonts.fa_arrow_up
    end

    -- Determine copy mode
    local copymode = ''
    if tab.active_pane.title:sub(1, 9) == 'Copy mode' then
        copymode = nerdfonts.cod_copy
    end

    -- Determine icon
    local icon = ''
    if copymode == '' then
        local process_name = tab.active_pane.foreground_process_name:match('([^/\\]+)$')
        icon = c.apps[process_name] or nerdfonts.seti_checkbox_unchecked
    end

    -- Determine prefix
    local prefix = zoomed .. copymode .. icon .. '  '

    -- Determine cwd
    local title = ''
    local cwd = tab.active_pane.current_working_dir
    if cwd == nil then
        title = '?'
    else
        local path = cwd.file_path
        if path == wezterm.home_dir then
            title = '~'
        elseif path == '/' then
            title = '/'
        else
            title = path:match('([^/]+)$')
        end
    end

    -- Make sure it fits
    local fluff = 3 + #prefix
    if #title > constants.tab_max_width - fluff then
        title = wezterm.truncate_right(title, constants.tab_max_width - fluff - 1) .. '…'
    end

    if tab.is_active then
        local color = c.color_active_bg
        if copymode ~= '' then
            color = c.color_copy_mode
        end
        return {
            { Background = { Color = c.color_bg } },
            { Foreground = { Color = color } },
            { Text = ' ' .. c.left_circle },
            { Background = { Color = color } },
            { Foreground = { Color = c.color_active_fg } },
            { Text = prefix .. title },
            { Background = { Color = c.color_bg } },
            { Foreground = { Color = color } },
            { Text = c.right_circle },
        }
    else
        return {
            { Background = { Color = c.color_bg } },
            { Foreground = { Color = c.color_inactive_bg } },
            { Text = ' ' .. c.left_circle },
            { Background = { Color = c.color_inactive_bg } },
            { Foreground = { Color = c.color_inactive_fg } },
            { Text = prefix .. title },
            { Background = { Color = c.color_bg } },
            { Foreground = { Color = c.color_inactive_bg } },
            { Text = c.right_circle },
        }
    end
end)

plugin_smart_splits.apply_to_config(config)

return config
