local wezterm = require 'wezterm';

return {
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
                font = wezterm.font({family="Noto Sans", weight="Bold"}),

                -- The size of the font in the tab bar.
                -- Default to 10. on Windows but 12.0 on other systems
                font_size = 9.0,
        },
        hide_tab_bar_if_only_one_tab = true,
        font = wezterm.font("MonoLisa", {weight="Light", italic=false}),
        font_size = 8.0,
        color_scheme = "Gruvbox Dark",
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
        }
}
