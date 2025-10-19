-- LSP Config
local keymap = require("utils.keymap")
local nnoremap = keymap.nnoremap

vim.opt.signcolumn = 'yes'

local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lspconfig_defaults.capabilities,
    require('blink.cmp').get_lsp_capabilities()
)

local function diagnostics()
    vim.diagnostic.config({ virtual_lines = { current_line = true }, virtual_text = false })

    vim.api.nvim_create_autocmd('CursorMoved', {
        group = vim.api.nvim_create_augroup('line-diagnostics', { clear = true }),
        callback = function()
            vim.diagnostic.config({ virtual_lines = false, virtual_text = true })
            return true
        end,
    })
end

vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function()
        local mode = vim.api.nvim_get_mode().mode
        local filetype = vim.bo.filetype
        if vim.bo.modified == true and mode == 'n' and filetype ~= "oil" and filetype ~= "cpp" and filetype ~= "c" then
            vim.cmd('lua vim.lsp.buf.format()')
        end
    end
})
vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        local opts = { buffer = event.buf, remap = false }
        nnoremap('gp', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
        nnoremap('gn', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
        nnoremap('ä', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
        nnoremap('\'', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
        nnoremap("å", diagnostics, opts)
        nnoremap("[", diagnostics, opts)

        nnoremap('gD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
        nnoremap('gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
        nnoremap('ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
        nnoremap('gs', '<cmd>lua require"telescope.builtin".lsp_document_symbols{ shorten_path = true }<CR>', opts)

        nnoremap("<leader>h", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end)
    end
})

vim.lsp.config('gopls', {
    settings = {

        gopls = {
            semanticTokens = true,
            gofumpt = true,
            usePlaceholders = true,
            staticcheck = true,
            analyses = {
                nilness = true,
                unusedparams = true,
                unusedwrite = true,
            },
            codelenses = {
                tidy = true
            },
        },
    },
    directoryFilters = { "-bazel-bin", "-bazel-src", "-bazel-out", "-**/node_modules", "-**/bazel-out", "-**/bazel-bin", "-**/bazel-src", "-**/bazel-testlogs" },
})

vim.lsp.config('lua_ls', {
    -- Server-specific settings. See `:help lsp-quickstart`
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using
                -- (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {
                    'vim',
                    'require'
                },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
})


vim.lsp.config('clangd', {
    -- Server-specific settings. See `:help lsp-quickstart`
    settings = {
        clangd = {
            cmd = {
                "clangd",
                "--background-index",
                "--suggest-missing-includes",
            },
            filetypes = { "c", "cpp", "objc", "objcpp" },
        },
    },
})

vim.lsp.config('rust_analyzer', {
    -- Server-specific settings. See `:help lsp-quickstart`
    settings = {
        ['rust-analyzer'] = {

            add_return_type = {
                enable = true
            },
            cargo = {
                runBuildScripts = true,
                loadOutDirsFromCheck = true,
                allFeatures = true,
                features = { "ssr" },
            },
            imports = {
                group = {
                    enable = true,
                },
                granularity = {
                    group = "module",
                },
                prefix = "self",
            },
            completion = {
                fullFunctionSignatures = {
                    enable = true,
                },
            },
            procMacro = {
                enable = true,
                ignored = {
                    ["leptos_macro"] = {
                        -- optional: --
                        -- "component",
                        -- "server",
                    },
                    ["async-trait"] = { "async_trait" },
                    ["napi-derive"] = { "napi" },
                    ["async-recursion"] = { "async_recursion" },
                },
            },
            checkOnSave = true,
            check = {
                -- features = "all",
                ignore = { "inactive-code", "unlinked-file" },
                command = "clippy",
                extraArgs = {},
            },

        },
    },
})

local _border = "rounded"


vim.diagnostic.config({
    virtual_text = true,
    underline = {
        severity = {
            vim.diagnostic.severity.ERROR,
            vim.diagnostic.severity.WARN
        }
    },
    -- underline = false,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '',
            [vim.diagnostic.severity.WARN] = '',
            [vim.diagnostic.severity.INFO] = '',
            [vim.diagnostic.severity.HINT] = '',
        }
    },
    update_in_insert = true,
    severity_sort = false,
})

vim.o.winborder = _border

vim.diagnostic.config {
    float = { border = _border }
}

require('lspconfig.ui.windows').default_options = {
    border = _border
}
