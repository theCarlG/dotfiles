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
        {
            'christoomey/vim-tmux-navigator',
            cmd = {
                "TmuxNavigateLeft",
                "TmuxNavigateDown",
                "TmuxNavigateUp",
                "TmuxNavigateRight",
                "TmuxNavigatePrevious",
                "TmuxNavigatorProcessList",
            },
            init = function()
                -- Reusable function to register keymaps in different contexts
                local function set_keymaps()
                    vim.keymap.set({ "n", "t" }, "<C-h>", "<cmd>TmuxNavigateLeft<cr>")
                    vim.keymap.set({ "n", "t" }, "<C-j>", "<cmd>TmuxNavigateDown<cr>")
                    vim.keymap.set({ "n", "t" }, "<C-k>", "<cmd>TmuxNavigateUp<cr>")
                    vim.keymap.set({ "n", "t" }, "<C-l>", "<cmd>TmuxNavigateRight<cr>")
                end

                -- Register once globally
                set_keymaps()

                -- Re-register for terminal buffers to prevent literal command injection
                vim.api.nvim_create_autocmd("TermOpen", {
                    callback = set_keymaps,
                })
            end,
        },
        { 'mg979/vim-visual-multi' },
        {
            'rmagatti/auto-session',
            lazy = false,
            keys = {
                -- Will use Telescope if installed or a vim.ui.select picker otherwise
                { "<leader>wr", "<cmd>AutoSession search<CR>", desc = "Session search" },
                { "<leader>ws", "<cmd>AutoSession save<CR>",   desc = "Save session" },
                { "<leader>wa", "<cmd>AutoSession toggle<CR>", desc = "Toggle autosave" },
            },
            dependencies = {
                { 'nvim-lua/telescope.nvim' },
            },

            opts = {
                -- The following are already the default values, no need to provide them if these are already the settings you want.
                session_lens = {
                    suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
                    picker = 'telescope', -- "telescope"|"snacks"|"fzf"|"select"|nil Pickers are detected automatically but you can also manually choose one. Falls back to vim.ui.select
                    mappings = {
                        -- Mode can be a string or a table, e.g. {"i", "n"} for both insert and normal mode
                        delete_session = { "i", "<C-d>" },
                        alternate_session = { "i", "<C-s>" },
                        copy_session = { "i", "<C-y>" },
                    },

                    picker_opts = {
                    },

                    -- Telescope only: If load_on_setup is false, make sure you use `:AutoSession search` to open the picker as it will initialize everything first
                    load_on_setup = true,
                },
            },
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
