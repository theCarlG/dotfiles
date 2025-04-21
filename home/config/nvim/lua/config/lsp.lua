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
        if vim.bo.modified == true and mode == 'n' and filetype ~= "oil" then
            vim.cmd('lua vim.lsp.buf.format()')
        else
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
        -- nnoremap('å', '<cmd>lua vim.diagnostic.open_float(nil, { focusable = false })<CR>', opts)
        -- nnoremap('[', '<cmd>lua vim.diagnostic.open_float(nil, { focusable = false })<CR>', opts)
        nnoremap("å", diagnostics, opts)
        nnoremap("[", diagnostics, opts)

        --nnoremap('gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
        nnoremap('gD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
        nnoremap('gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
        -- nnoremap('gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
        --nnoremap('gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
        nnoremap('ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
        -- nnoremap('grn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
        -- nnoremap('grr', '<cmd>Telescope lsp_references<CR>', opts)
        nnoremap('gs', '<cmd>lua require"telescope.builtin".lsp_document_symbols{ shorten_path = true }<CR>', opts)

        nnoremap("<leader>h", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end)
    end
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

        erlangls = function()
            require('lspconfig').erlangls.setup({
            })
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
                        },
                    },
                },
            })
        end
    }
})

local _border = "rounded"


vim.diagnostic.config({
    virtual_text = true,
    underline = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '✘',
            [vim.diagnostic.severity.WARN] = '▲',
            [vim.diagnostic.severity.INFO] = '⚑',
            [vim.diagnostic.severity.HINT] = '»',
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
