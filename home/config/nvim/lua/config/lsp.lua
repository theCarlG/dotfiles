-- LSP Config
local keymap = require("utils.keymap")
local nnoremap = keymap.nnoremap

require("mason").setup()
local lsp = require("lsp-zero")

local lsp_attach = function(client, bufnr)
    lsp.buffer_autoformat()
    local opts = { buffer = bufnr, remap = false }
    nnoremap('gp', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    nnoremap('gn', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    nnoremap('ä', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    nnoremap('\'', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    nnoremap('å', '<cmd>lua vim.diagnostic.open_float(nil, { focusable = false })<CR>', opts)
    nnoremap('[', '<cmd>lua vim.diagnostic.open_float(nil, { focusable = false })<CR>', opts)

    --nnoremap('gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    nnoremap('gD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    nnoremap('gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    -- nnoremap('gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    --nnoremap('gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    nnoremap('ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    -- nnoremap('grn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    -- nnoremap('grr', '<cmd>Telescope lsp_references<CR>', opts)
    nnoremap('gs', '<cmd>lua require"telescope.builtin".lsp_document_symbols{ shorten_path = true }<CR>', opts)

    -- When https://neovim.io/doc/user/lsp.html#lsp-inlay_hint stabilizes
    -- *and* there's some way to make it only apply to the current line.
    if client.server_capabilities.inlayHintProvider then
        nnoremap("<leader>h", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end)
    end
end

lsp.extend_lspconfig({
    sign_text = true,
    lsp_attach = lsp_attach,
    capabilities = require('blink.cmp').get_lsp_capabilities()
})

require('mason-lspconfig').setup({
    automatic_installation = false,
    -- Replace the language servers listed here
    -- with the ones you want to install
    ensure_installed = {
        'rust_analyzer',
        'erlangls',
        'clangd',
        'lua_ls',
    },
    handlers = {
        function(server_name)
            require('lspconfig')[server_name].setup({})
        end,

        gopls = function()
            require('lspconfig').gopls.setup({
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
        end,

        lua_ls = function()
            require('lspconfig').lua_ls.setup({
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
        end,

        clangd = function()
            require('lspconfig').clangd.setup({
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
        end,

        rust_analyzer = function()
            require('lspconfig').rust_analyzer.setup({
                settings = {
                    ['rust-analyzer'] = {
                        add_return_type = {
                            enable = true
                        },
                        cargo = {
                            runBuildScripts = true,
                            loadOutDirsFromCheck = true,
                            allFeatures = true,
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
                                leptos_macro = {
                                    -- optional: --
                                    -- "component",
                                    -- "server",
                                },
                            },
                        },
                        checkOnSave = true,
                        check = {
                            features = "all",
                            ignore = { "inactive-code", "unlinked-file" },
                            command = "clippy",
                        },
                    },
                },
            })
        end
    }
})

lsp.ui({
    float_border = 'rounded',
    sign_text = {
        error = '✘',
        warn = '▲',
        hint = '⚑',
        info = '»',
    },
})

lsp.setup()

vim.diagnostic.config({
    -- Use the default configuration
    virtual_lines = true,

    -- Alternatively, customize specific options
    -- virtual_lines = {
    --     -- Only show virtual line diagnostics for the current cursor line
    --     current_line = true,
    -- },
    signs = true,
    update_in_insert = true,
    severity_sort = true,
})

local _border = "rounded"

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover, {
        wrap = true,
        border = _border
    }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help, {
        border = _border
    }
)

vim.diagnostic.config {
    float = { border = _border }
}

require('lspconfig.ui.windows').default_options = {
    border = _border
}
