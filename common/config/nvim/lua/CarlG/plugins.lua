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
        --[[ Misc ]]
        { 'christoomey/vim-tmux-navigator' },
        { 'mg979/vim-visual-multi' },
        {
            'rmagatti/auto-session',
            lazy = false,
            opts = {
                suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
                -- log_level = 'debug',
            }
        },
        {
            'lewis6991/gitsigns.nvim',
            config = function()
                require('gitsigns').setup {}
            end
        },

        --[[ Neovim LSP Plugins ]]
        {
            'williamboman/mason.nvim',
            lazy = false,
            config = true,
        },
        {
            'VonHeikemen/lsp-zero.nvim',
            branch = 'v4.x',
            lazy = true,
            config = false,

            dependencies = {
                { 'neovim/nvim-lspconfig' },
                { 'williamboman/mason-lspconfig.nvim' },
            },
        },

        {
            'hrsh7th/nvim-cmp',
            dependencies = {
                -- Autocompletion
                { 'hrsh7th/cmp-nvim-lsp' },
                { 'hrsh7th/cmp-buffer' },
                { 'hrsh7th/cmp-path' },
                { 'onsails/lspkind.nvim' },
                -- -- Snippets
                {
                    "L3MON4D3/LuaSnip",
                    dependencies = { "rafamadriz/friendly-snippets" },
                    build = "make install_jsregexp",
                    config = function()
                        require("luasnip.loaders.from_vscode").lazy_load()
                    end,
                },
                { 'saadparwaiz1/cmp_luasnip' }
            }
        },

        --[[ Treesitter ]]
        {
            'nvim-treesitter/nvim-treesitter',
            run = ':TSUpdate',
            dependencies = {
                { 'nvim-treesitter/nvim-treesitter-context' },
            }
        },

        --[[ Themes ]]
        { 'gruvbox-community/gruvbox' },

        --[[ Utilities ]]
        { 'tpope/vim-fugitive' },
        {
            "windwp/nvim-autopairs",
            config = function() require("nvim-autopairs").setup {} end
        },
        {
            'numToStr/Comment.nvim',
            config = function()
                require('Comment').setup()
            end
        },

        --[[ Lualine ]]
        { 'nvim-lualine/lualine.nvim' },

        --[[ Telescope ]]
        { 'nvim-lua/popup.nvim',      branch = 'master' },
        { 'nvim-lua/plenary.nvim',    branch = 'master' },
        { 'nvim-lua/telescope.nvim',  branch = 'master' },
    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "gruvbox" } },
    -- automatically check for plugin updates
    checker = { enabled = true },
})
