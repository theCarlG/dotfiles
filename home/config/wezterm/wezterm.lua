local wezterm = require 'wezterm'

local mux = wezterm.mux

wezterm.on("gui-startup", function()
    local tab, pane, window = mux.spawn_window(cmd or {})
    window:gui_window():maximize()
end)

-- https://alexplescan.com/posts/2024/08/10/wezterm/
wezterm.on('update-status', function(window)
    -- Grab the utf8 character for the "powerline" left facing
    -- solid arrow.
    local SOLID_LEFT_ARROW = utf8.char(0xe0b2)

    -- Grab the current window's configuration, and from it the
    -- palette (this is the combination of your chosen colour scheme
    -- including any overrides).
    local color_scheme = window:effective_config().resolved_palette
    local bg = color_scheme.background
    local fg = color_scheme.foreground

    window:set_right_status(wezterm.format({
        -- First, we draw the arrow...
        { Background = { Color = 'none' } },
        { Foreground = { Color = bg } },
        { Text = SOLID_LEFT_ARROW },
        -- Then we draw our text
        { Background = { Color = bg } },
        { Foreground = { Color = fg } },
        { Text = ' ' .. wezterm.hostname() .. ' ' },
    }))
end)

function get_appearance()
    -- if wezterm.gui then
    --     return wezterm.gui.get_appearance()
    -- end
    return 'Dark'
end

function scheme_for_appearance(appearance)
    if appearance:find('Dark') then
        return "gruvbox_material_dark_hard"
    else
        return "gruvbox_material_light_hard"
    end
end

local config = {
    launch_menu = launch_menu,
    enable_wayland = true,
    window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0,
    },
    window_frame = {
        -- The font used in the tab bar.
        -- Roboto Bold is the default; this font is bundled
        -- with wezterm.
        -- Whatever font is selected here, it will have the
        -- main font setting appended to it to pick up any
        -- fallback fonts you may have used there.
        font = wezterm.font({ family = "Roboto", weight = "Bold" }),

        -- The size of the font in the tab bar.
        -- Default to 10. on Windows but 12.0 on other systems
        font_size = 9.0,
    },
    --hide_tab_bar_if_only_one_tab = false,
    window_decorations = 'RESIZE',
    audible_bell = "Disabled",
    warn_about_missing_glyphs = false,
    font = wezterm.font("MonoLisa Nerd Font", { weight = "Light", italic = false }),
    font_size = 8.0,
    font_rules = {
        -- Select a fancy italic font for italic text
        {
            italic = true,
            font = wezterm.font("MonoLisa Nerd Font", { weight = "ExtraLight", italic = true }),
        },

        -- Similarly, a fancy bold+italic font
        {
            italic = true,
            intensity = "Bold",
            font = wezterm.font("MonoLisa Nerd Font", { weight = "Bold", italic = true }),
        },

        -- Make regular bold text a different color to make it stand out even more
        {
            intensity = "Bold",
            font = wezterm.font("MonoLisa Nerd Font", { weight = "Bold", italic = false }),
        },

        -- For half-intensity text, use a lighter weight font
        {
            intensity = "Half",
            font = wezterm.font("MonoLisa Nerd Font", { weight = "ExtraLight", italic = false }),
        },
    },
    color_scheme = scheme_for_appearance(get_appearance()),
    color_schemes = {
        ["gruvbox_material_dark_hard"] = {
            foreground = "#D4BE98",
            background = "#1C1C1C",
            cursor_bg = "#D4BE98",
            cursor_border = "#D4BE98",
            cursor_fg = "#1D2021",
            selection_bg = "#D4BE98",
            selection_fg = "#3C3836",

            ansi = { "#282828", "#cc241d", "#98971a", "#d79921", "#458588", "#b16286", "#689d6a", "#a89984" },
            --ansi = { "#1d2021", "#ea6962", "#a9b665", "#d8a657", "#7daea3", "#d3869b", "#89b482", "#d4be98" },
            --brights = { "#eddeb5", "#ea6962", "#a9b665", "#d8a657", "#7daea3", "#d3869b", "#89b482", "#d4be98" }
            brights = { "#928374", "#fb4934", "#b8bb26", "#fabd2f", "#83a598", "#d3869b", "#8ec07c", "#ebdbb2" },
        },
        ["gruvbox_material_dark_medium"] = {
        },
        ["gruvbox_material_dark_soft"] = {
        },
        ["gruvbox_material_light_hard"] = {
            foreground = "#654735",
            background = "#FBF1C6",
            cursor_bg = "#654735",
            cursor_border = "#654735",
            cursor_fg = "#F9F5D7",
            selection_bg = "#F3EAC7",
            selection_fg = "#4F3829",

            ansi = { "#1d2021", "#ea6962", "#a9b665", "#d8a657", "#7daea3", "#d3869b", "#89b482", "#d4be98" },
            brights = { "#eddeb5", "#ea6962", "#a9b665", "#d8a657", "#7daea3", "#d3869b", "#89b482", "#d4be98" }
        },
        ["gruvbox_material_light_medium"] = {
        },
        ["gruvbox_material_light_soft"] = {
        },
    },

    keys = {
        {
            key = "-",
            mods = "CTRL|SHIFT",
            action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
        },
        {
            key = "ö",
            mods = "CTRL|SHIFT",
            action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
        },
        {
            key = "h",
            mods = "CTRL|SHIFT",
            action = wezterm.action.ActivatePaneDirection("Left"),
        },
        {
            key = "j",
            mods = "CTRL|SHIFT",
            action = wezterm.action.ActivatePaneDirection("Down"),
        },
        {
            key = "k",
            mods = "CTRL|SHIFT",
            action = wezterm.action.ActivatePaneDirection("Up"),
        },
        {
            key = "l",
            mods = "CTRL|SHIFT",
            action = wezterm.action.ActivatePaneDirection("Right"),
        },
    }
}

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
    local launch_menu = {}

    table.insert(launch_menu, {
        label = "PowerShell",
        domain = { DomainName = "local" },
        args = { "powershell.exe", "-nologo" },
    })
    table.insert(launch_menu, {
        label = "Git Bash",
        domain = { DomainName = "local" },
        args = {
            "C:\\Program Files\\Git\\bin\\bash.exe",
        }
    })

    config.default_prog = { "C:\\Program Files\\Git\\bin\\bash.exe" }
    config.launch_menu = launch_menu
    config.default_domain = "WSL:Ubuntu"
end

return config
