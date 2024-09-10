vim.g.gruvbox_baby_background_color = "dark"
vim.g.gruvbox_contrast_dark = 'hard'
vim.g.gruvbox_contrast_light = 'medium'
vim.g.gruvbox_invert_tabline = '1'
vim.g.gruvbox_bold = 1
vim.g.gruvbox_italic = 1
vim.g.gruvbox_improved_strings = 0
vim.g.gruvbox_improved_warnings = 1
vim.g.gruvbox_invert_selection = '0'

vim.opt.background = "dark"

vim.cmd.colorscheme 'gruvbox'

local hl = function(thing, opts)
    vim.api.nvim_set_hl(0, thing, opts)
end

hl("SignColumn", {
    bg = "none",
})

hl("ColorColumn", {
    ctermbg = 0,
    bg = "#555555",
})

hl("CursorLineNR", {
    bg = "none"
})

hl("Normal", {
    bg = "none"
})

hl("LineNr", {
    fg = "#5eacd3"
})

hl("netrwDir", {
    fg = "#5eacd3"
})


hl("FloatBorder", {
    bg = "none"
})
hl("NormalFloat", {
    bg = "none"
})
