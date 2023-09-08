local dap = require("dap")
local dapui = require("dapui")
local daptext = require("nvim-dap-virtual-text")

require("mason-nvim-dap").setup({
    ensure_installed = { "delve", "bash-debug-adapter", "codelldb" }
})

local mason_registry = require("mason-registry")
local codelldb = mason_registry.get_package("codelldb")
local extension_path = codelldb:get_install_path() .. "/extension/"
local codelldb_path = extension_path .. "adapter/codelldb"
local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

dap.adapters.lldb = {
  type = 'server',
  port = "${port}",
  executable = {
    -- Change this to your path!
    command =  codelldb_path,
    args = {"--port", "${port}"},
  }
}
dap.configurations.rust = {
  {
    name = "Launch file",
    type = "lldb",
    request = "launch",
    program = function()
      vim.fn.jobstart('cargo build')
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  },
}
dap.configurations.c = dap.configurations.rust
dap.configurations.cpp = dap.configurations.rust

require('dap.ext.vscode').load_launchjs(nil, {lldb={'rust'}})

require('dap-go').setup {
    dap_configurations = {
        {
            type = 'go',
            request = 'attach',
            name = 'Attach to Go Process',
            mode = 'local',
            processId = require('dap.utils').pick_process,
        },
        {
            -- Must be "go" or it will be ignored by the plugin
            type = "go",
            name = "Attach remote",
            mode = "remote",
            request = "attach",
        },
        {
            type = "delve",
            name = "Debug",
            request = "launch",
            mode = "exec",
            program = "${file}"
        },
        {
            type = "delve",
            name = "Debug test", -- configuration for debugging test files
            request = "launch",
            mode = "test",
            program = "${file}"
        },
        {
            type = "delve",
            name = "Debug test (go.mod)",
            request = "launch",
            mode = "test",
            program = "./${relativeFileDirname}"
        },
    },
    -- delve configurations
    delve = {
        initialize_timeout_sec = 20,
        port = "${port}"
    },
}

daptext.setup()
dapui.setup()
--{
--    layouts = {
--        {
--            elements = {
--                "console",
--            },
--            size = 7,
--            position = "bottom",
--        },
--        {
--            elements = {
--                -- Elements can be strings or table with id and size keys.
--                { id = "scopes", size = 0.25 },
--                "watches",
--            },
--            size = 40,
--            position = "left",
--        }
--    },
--})

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open(1)
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end



local api = vim.api
local keymap_restore = {}
dap.listeners.after['event_initialized']['me'] = function()
  for _, buf in pairs(api.nvim_list_bufs()) do
    local keymaps = api.nvim_buf_get_keymap(buf, 'n')
    for _, keymap in pairs(keymaps) do
      if keymap.lhs == "K" then
        table.insert(keymap_restore, keymap)
        api.nvim_buf_del_keymap(buf, 'n', 'K')
      end
    end
  end
  api.nvim_set_keymap(
    'n', 'K', '<Cmd>lua require("dap.ui.widgets").hover()<CR>', { silent = true })
end

dap.listeners.after['event_terminated']['me'] = function()
  for _, keymap in pairs(keymap_restore) do
    api.nvim_buf_set_keymap(
      keymap.buffer,
      keymap.mode,
      keymap.lhs,
      keymap.rhs,
      { silent = keymap.silent == 1 }
    )
  end
  keymap_restore = {}
end

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
