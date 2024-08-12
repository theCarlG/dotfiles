local wezterm = require 'wezterm'
local mux = wezterm.mux

wezterm.on("gui-startup", function()
    local tab, pane, window = mux.spawn_window(cmd or {})
    window:gui_window():maximize()
end)

return {
    enable_wayland = true,
    window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0,
    },
    dpi = 192.0,
    window_frame = {
        -- The font used in the tab bar.
        -- Roboto Bold is the default; this font is bundled
        -- with wezterm.
        -- Whatever font is selected here, it will have the
        -- main font setting appended to it to pick up any
        -- fallback fonts you may have used there.
        font = wezterm.font({family="Noto Sans", weight="Bold"}),

        -- The size of the font in the tab bar.
        -- Default to 10. on Windows but 12.0 on other systems
        font_size = 9.0,
    },
    hide_tab_bar_if_only_one_tab = true,
    font = wezterm.font("MonoLisa", {weight="Light", italic=false}),
    font_size = 8.0,
    font_rules= {
        -- Select a fancy italic font for italic text
        {
            italic = true,
            font = wezterm.font("MonoLisa", {weight="Light", italic=true}),
        },

        -- Similarly, a fancy bold+italic font
        {
            italic = true,
            intensity = "Bold",
            font = wezterm.font("MonoLisa", {weight="Bold", italic=true}),
        },

        -- Make regular bold text a different color to make it stand out even more
        {
            intensity = "Bold",
            font = wezterm.font("MonoLisa", {weight="Bold", italic=false}),
        },

        -- For half-intensity text, use a lighter weight font
        {
            intensity = "Half",
            font = wezterm.font("MonoLisa", {weight="Light", italic=false}),
        },
    },
    color_scheme = "gruvbox_material_dark_hard",
    color_schemes = {
        ["gruvbox_material_dark_hard"] = {
            foreground = "#D4BE98",
            background = "#1C1F20",
            cursor_bg = "#D4BE98",
            cursor_border = "#D4BE98",
            cursor_fg = "#1D2021",
            selection_bg = "#D4BE98" ,
            selection_fg = "#3C3836",

            ansi = {"#1d2021","#ea6962","#a9b665","#d8a657", "#7daea3","#d3869b", "#89b482","#d4be98"},
            brights = {"#eddeb5","#ea6962","#a9b665","#d8a657", "#7daea3","#d3869b", "#89b482","#d4be98"}
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
            selection_bg = "#F3EAC7" ,
            selection_fg = "#4F3829",

            ansi = {"#1d2021","#ea6962","#a9b665","#d8a657", "#7daea3","#d3869b", "#89b482","#d4be98"},
            brights = {"#eddeb5","#ea6962","#a9b665","#d8a657", "#7daea3","#d3869b", "#89b482","#d4be98"}
        },
        ["gruvbox_material_light_medium"] = {
        },
        ["gruvbox_material_light_soft"] = {
        },
    },
}
