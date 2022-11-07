-- LSP Config
local keymap = require("CarlG.utils.keymap")
local nnoremap = keymap.nnoremap
local vnoremap = keymap.vnoremap

local nvim_lsp = require'lspconfig'
local util = require 'lspconfig/util'
local configs = require 'lspconfig/configs'

local on_attach = function(client, bufnr)
    local opts = { noremap=true, silent=true, buffer=bufnr }
    nnoremap('gp', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    nnoremap('gn', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    nnoremap('ä', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    nnoremap('å', '<cmd>lua vim.diagnostic.open_float(nil, { focusable = false })<CR>', opts)

    --nnoremap('gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    nnoremap('gD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    nnoremap('gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    nnoremap('gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    nnoremap('K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    --nnoremap('gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    nnoremap('ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    nnoremap('gre', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    --nnoremap('gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
end

nvim_lsp.please.setup{
    capabilities=capabilities,
    on_attach = on_attach,
}

if not configs.golangcilsp then
    configs.golangcilsp = {
        default_config = {
            cmd = {'golangci-lint-langserver', "-debug"},
            root_dir = nvim_lsp.util.root_pattern('go.mod','.git'),
            init_options = {
                    command = { "golangci-lint", "run", "--enable-all", "--out-format", "json" };
            }
        };
    }
end
nvim_lsp.golangci_lint_ls.setup {
    filetypes = {'go','gomod'}
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
        'documentation',
        'detail',
        'additionalTextEdits',
    }
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = true,
        signs = true,
        update_in_insert = true,
    }
)

nvim_lsp.rust_analyzer.setup({
    cmd = { "rustup", "run", "stable", "rust-analyzer" },
    capabilities=capabilities,
    on_attach = on_attach,
    settings = {
        ["rust-analyzer"] = {
            assist = {
                importGranularity = "module",
                importPrefix = "by_self",
            },
            cargo = {
                runBuildScripts = true,
                loadOutDirsFromCheck = true,
            },
            procMacro = {
                enable = true,
            },
            checkOnSave = {
                command = "cranky",
            },
        }
    }
})

nvim_lsp.tsserver.setup{
    capabilities=capabilities,
    on_attach = on_attach,
}

nvim_lsp.gopls.setup({
    capabilities=capabilities,
    on_attach = on_attach,
    cmd = {"gopls", "serve"},
    filetypes = {"go", "gomod"},
    root_dir = util.root_pattern("go.work", "go.mod", ".git"),
    settings = {
        gopls = {
            gofumpt = true,
            usePlaceholders = true,
            staticcheck = true,
            analyses = {
                nilness = true,
                shadow = true,
                unusedparams = true,
                unusedwrite = true,
                fieldalignment = true
            },
            codelenses = {
                tidy = true
            },
            directoryFilters = {"-bazel-bin", "-bazel-src", "-bazel-out", "-**/node_modules", "-**/bazel-out", "-**/bazel-bin", "-**/bazel-src", "-**/bazel-testlogs"},
        },
    },
})

nvim_lsp.clangd.setup {
    capabilities=capabilities,
    on_attach = on_attach,
    default_config = {
    cmd = {
        "clangd", "--background-index", "--pch-storage=memory", "--clang-tidy", "--suggest-missing-includes"
    },
    filetypes = {"c", "cpp", "objc", "objcpp","h","hpp"},
    root_dir = nvim_lsp.util.root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
        init_option = {
            fallbackFlags = {
                clangd = {
                    fallbackFlags = {"-std=c++17"}
                }
            }
        }
    }
}

function OrgImports(wait_ms)
    local params = vim.lsp.util.make_range_params()
    params.context = {only = {"source.organizeImports"}}
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
    if result then
        for _, res in pairs(result or {}) do
            if res.result then
                for _, r in pairs(res.result or {}) do
                    if r.edit then
                        vim.lsp.util.apply_workspace_edit(r.edit)
                    else
                        vim.lsp.buf.execute_command(r.command)
                    end
                end
            end
        end
    end
end
function go_org_imports(wait_ms)
    vim.lsp.buf.formatting()
    local params = vim.lsp.util.make_range_params()
    params.context = {only = {"source.organizeImports"}}
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
    for cid, res in pairs(result or {}) do
        for _, r in pairs(res.result or {}) do
            if r.edit then
                local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
                vim.lsp.util.apply_workspace_edit(r.edit, enc)
            end
        end
    end
end

vim.api.nvim_command("au BufWritePre *.rs, lua vim.lsp.buf.format()")
vim.api.nvim_command("au BufWritePre *.js, lua vim.lsp.buf.format()")
vim.api.nvim_command("au BufWritePre *.c, lua vim.lsp.buf.format()")
vim.api.nvim_command("au BufWritePre *.cpp, lua vim.lsp.buf.format()")
vim.api.nvim_command("au BufEnter *.go setlocal noexpandtab")
vim.api.nvim_command("au BufEnter *.c setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2")
vim.api.nvim_command("au BufEnter *.h setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2")
vim.api.nvim_command("au BufWritePre *.go lua go_org_imports(1000)")

