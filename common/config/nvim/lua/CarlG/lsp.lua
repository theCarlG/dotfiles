-- LSP Config
local keymap = require("CarlG.utils.keymap")
local nnoremap = keymap.nnoremap
local vnoremap = keymap.vnoremap
local nmap = keymap.nmap

require("mason").setup()
local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
  'gopls',
  'rust_analyzer',
  'clangd',
})

local cmp = require('cmp')
local cmp_action = lsp.cmp_action()
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ['<C-f>'] = cmp_action.luasnip_jump_forward(),
  ['<C-b>'] = cmp_action.luasnip_jump_backward(),
  ['<CR>'] = cmp.mapping(function(fallback)
      -- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
      if cmp.visible() then
          local entry = cmp.get_selected_entry()
          if not entry then
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
          else
              cmp.confirm()
          end
      else
          fallback()
      end
  end, {"i","s","c",})
})

-- disable completion with tab
cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
    mapping = cmp_mappings,
    snippet = {
        -- REQUIRED by nvim-cmp. get rid of it once we can
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    sources = cmp.config.sources(
        {
            { name = 'nvim_lsp' },
        }, 
        {
            { name = 'path' },
        }
    ),
    experimental = {
        ghost_text = true,
    },
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = "E",
        warn  = "W",
        hint  = "H",
        info  = "I",
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

    -- When https://neovim.io/doc/user/lsp.html#lsp-inlay_hint stabilizes
    -- *and* there's some way to make it only apply to the current line.
    -- if client.server_capabilities.inlayHintProvider then
    --     vim.lsp.inlay_hint(ev.buf, true)
    -- end

    -- None of this semantics tokens business.
    -- https://www.reddit.com/r/neovim/comments/143efmd/is_it_possible_to_disable_treesitter_completely/
    -- client.server_capabilities.semanticTokensProvider = nil
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
                allFeatures = true,
            },
            imports = {
                group = {
                    enable = false,
                }
            },
            -- completion = {
            --     postfix = {
            --         enable = false,
            --     }
            -- },
            procMacro = {
                enable = true,
            },
            checkOnSave = true,
            check = {
                command = "clippy",
            },
        },
    }
})

lsp.configure('clangd', {
    settings = {
        clangd = {
            cmd = {
                "clangd",
                "--background-index",
                "--suggest-missing-includes",
                -- "--compile-commands-dir=/home/localuser/test/build",
            },
            filetypes = { "c", "cpp", "objc", "objcpp" },
        }
    }
})

lsp.configure('gopls', {
    settings = {
        gopls = {
            semanticTokens = true,
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
    severity_sort = true,
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

vim.api.nvim_command("au BufWritePre *.js, LspZeroFormat")
vim.api.nvim_command("au BufWritePre *.ts, LspZeroFormat")
vim.api.nvim_command("au BufWritePre *.vue, LspZeroFormat")
vim.api.nvim_command("au BufWritePre *.rs, LspZeroFormat")
vim.api.nvim_command("au BufWritePre *.js, LspZeroFormat")
-- vim.api.nvim_command("au BufWritePre *.c, LspZeroFormat")
-- vim.api.nvim_command("au BufWritePre *.cpp, LspZeroFormat")
vim.api.nvim_command("au BufWritePre *.go, LspZeroFormat")
vim.api.nvim_command("au BufWritePre *.wgsl, LspZeroFormat")

