return {
    {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
            -- vim.wo.foldmethod = 'expr'
            -- vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
        end,
        dependencies = {
            {
                'nvim-treesitter/nvim-treesitter-context',
                opts = {
                    -- A list of parser names, or "all"
                    ensure_installed = { "c", "lua", "rust", "dockerfile", "yaml", "json", "regex", "make", "markdown", "proto", "python", "sql", "toml", "erlang" },

                    -- Install parsers synchronously (only applied to `ensure_installed`)
                    sync_install = false,

                    indent = {
                        enable = true,
                    },

                    highlight = {
                        enable = true,
                        additional_vim_regex_highlighting = false,
                        use_languagetree = true,
                    },
                }
            },
        },
        opts = {
            enable = true,   -- Enable this plugin (Can be enabled/disabled later via commands)
            throttle = true, -- Throttles plugin updates (may improve performance)
            max_lines = 0,   -- How many lines the window should span. Values <= 0 mean no limit.
            patterns = {     -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
                -- For all filetypes
                -- Note that setting an entry here replaces all other patterns for this entry.
                -- By setting the 'default' entry below, you can control which nodes you want to
                -- appear in the context window.
                default = {
                    "function",
                    "method",
                    "for",
                    "while",
                    "if",
                    "switch",
                    "case",
                },

                rust = {
                    "loop_expression",
                    "impl_item",
                },

                typescript = {
                    "class_declaration",
                    "abstract_class_declaration",
                    "else_clause",
                },
            },
        },
    },
}
