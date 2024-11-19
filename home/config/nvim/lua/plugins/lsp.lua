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

    {
        --'hrsh7th/nvim-cmp',
        "iguanacucumber/magazine.nvim",
        name = "nvim-cmp", -- Otherwise highlighting gets messed up
        tag = "0.3",
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
}
