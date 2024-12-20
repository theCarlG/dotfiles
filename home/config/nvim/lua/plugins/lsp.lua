return {
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

    -- {
    --     --'hrsh7th/nvim-cmp',
    --     "iguanacucumber/magazine.nvim",
    --     name = "nvim-cmp", -- Otherwise highlighting gets messed up
    --     tag = "0.3",
    --     dependencies = {
    --         -- Autocompletion
    --         { 'hrsh7th/cmp-nvim-lsp' },
    --         { 'hrsh7th/cmp-buffer' },
    --         { 'hrsh7th/cmp-path' },
    --         { 'onsails/lspkind.nvim' },
    --         -- -- Snippets
    --         {
    --             "L3MON4D3/LuaSnip",
    --             dependencies = { "rafamadriz/friendly-snippets" },
    --             build = "make install_jsregexp",
    --             config = function()
    --                 require("luasnip.loaders.from_vscode").lazy_load()
    --             end,
    --         },
    --         { 'saadparwaiz1/cmp_luasnip' }
    --     }
    -- },
    --
    {
        'saghen/blink.cmp',
        dependencies = 'rafamadriz/friendly-snippets',
        version = 'v0.*',
        -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
        -- build = 'cargo build --release',

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = { preset = 'enter' },

            appearance = {
                use_nvim_cmp_as_default = true,
                -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = 'mono'
            },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },

            -- experimental signature help support
            signature = { enabled = true }
        },
    },
}
