local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = {
        { import = "plugins" },
        --[[ Misc ]]
        { 'OXY2DEV/markview.nvim' },
        { 'christoomey/vim-tmux-navigator' },
        { 'mg979/vim-visual-multi' },
        {
            'rmagatti/auto-session',
            lazy = false,
            dependencies = {
                { 'nvim-lua/telescope.nvim' },
            },
            opts = {
                suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
                -- log_level = 'debug',
            }
        },
        {
            'lewis6991/gitsigns.nvim',
            opts = {}
        },

        --[[ Themes ]]
        { 'gruvbox-community/gruvbox' },
        {
            "f-person/auto-dark-mode.nvim",
            opts = {}
        },

        --[[ Utilities ]]
        { 'tpope/vim-fugitive' },
        {
            "windwp/nvim-autopairs",
            opts = {}
        },
        {
            'numToStr/Comment.nvim',
            opts = {}
        },

        --[[ Lualine ]]
        {
            'nvim-lualine/lualine.nvim',
            opts = {
                options = {
                    icons_enabled = true,
                    theme = 'auto',
                    component_separators = { left = '', right = '' },
                    section_separators = { left = '', right = '' },
                    disabled_filetypes = {},
                    always_divide_middle = true,
                    globalstatus = false,
                },
                sections = {
                    lualine_a = { 'mode' },
                    lualine_b = {
                        'branch',
                        'diff',
                        {
                            'diagnostics',
                            symbols = {
                                error = ' ',
                                warn = ' ',
                                info = ' ',
                                hint = ' '
                            }
                        }
                    },
                    lualine_c = { { 'filename', path = 1 } },
                    lualine_x = { 'encoding', 'fileformat', 'filetype' },
                    lualine_y = { 'progress' },
                    lualine_z = { 'location' }
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { { 'filename', path = 1 } },
                    lualine_x = { 'location' },
                    lualine_y = {},
                    lualine_z = {}
                },
                tabline = {},
                extensions = {}
            }


        },
    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "gruvbox" } },
    -- automatically check for plugin updates
    checker = { enabled = true },
})
