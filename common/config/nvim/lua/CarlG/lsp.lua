-- LSP Config
local keymap = require("CarlG.utils.keymap")
local nnoremap = keymap.nnoremap
local vnoremap = keymap.vnoremap

require("mason").setup()

local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
  'gopls',
  'rust_analyzer',
  'clangd',
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
})

-- disable completion with tab
-- this helps with copilot setup
cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.on_attach(function(client, bufnr)
    local opts = {buffer = bufnr, remap = false}
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
    nnoremap('gr', '<cmd>Telescope lsp_references<CR>', opts)
end)


lsp.configure('rust_analyzer', {
    settings = {
        ["rust-analyzer"] = {
            assist = {
                importGranularity = "module",
                importPrefix = "by_self",
            },
            cargo = {
                runBuildScripts = true,
                loadOutDirsFromCheck = true,
                --features = {"ssr"},
            },
            procMacro = {
                enable = true,
            },
            checkOnSave = true,
            check = {
                command = "cranky",
            },
        },
    }
})

lsp.configure('gopls', {
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

lsp.setup()

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    update_in_insert = true,
})

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

vim.api.nvim_command("au BufWritePre *.js, LspZeroFormat")
vim.api.nvim_command("au BufWritePre *.ts, LspZeroFormat")
vim.api.nvim_command("au BufWritePre *.vue, LspZeroFormat")
vim.api.nvim_command("au BufWritePre *.rs, LspZeroFormat")
vim.api.nvim_command("au BufWritePre *.js, LspZeroFormat")
vim.api.nvim_command("au BufWritePre *.c, LspZeroFormat")
vim.api.nvim_command("au BufWritePre *.cpp, LspZeroFormat")
vim.api.nvim_command("au BufWritePre *.go, LspZeroFormat")
vim.api.nvim_command("au BufWritePre *.wgsl, LspZeroFormat")
--vim.api.nvim_command("au BufWritePre *.go lua go_org_imports(1000)")
