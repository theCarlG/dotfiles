local border_chars = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }

return {
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                'rust_analyzer',
                'clangd',
                'lua_ls',
                'taplo',
            },
        },
        dependencies = {
            {
                'mason-org/mason.nvim',
                lazy = false,
                config = function()
                    require("mason").setup({
                        ui = {
                            icons = {
                                package_installed = "",
                                package_pending = "",
                                package_uninstalled = "",
                            },
                        }
                    })
                end,
            },
            "neovim/nvim-lspconfig",
        },
    },
    {
        'saghen/blink.cmp',
        dependencies = 'rafamadriz/friendly-snippets',
        version = 'v1.*',
        -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
        -- build = 'cargo build --release',

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            cmdline = {
                keymap = {
                    -- recommended, as the default keymap will only show and select the next item
                    ['<Tab>'] = { 'show', 'accept' },
                },
                completion = { menu = { auto_show = true } },
            },
            keymap = {
                preset = 'default',
            },
            completion = {
                menu = {
                    auto_show = function(_ctx)
                        return not vim.tbl_contains({ '/', '?' }, vim.fn.getcmdtype())
                    end,
                    border = border_chars,
                },

                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 0,
                    window = {
                        border = border_chars,
                    },
                },
                list = { selection = { preselect = true, auto_insert = true } },
            },

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
            signature = {
                enabled = true,
                window = { border = border_chars },
            },
        },
    },
}
