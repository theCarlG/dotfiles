local dap = require("dap")
local dapui = require("dapui")
local daptext = require("nvim-dap-virtual-text")

require("mason-nvim-dap").setup({
    ensure_installed = { "delve", "bash-debug-adapter", "codelldb" }
})

dap.adapters.codelldb = {
   type = 'server',
   port = "31337",
   executable = {
     command = 'codelldb',
     args = { "--port", "31337" },
   }
}
dap.configurations.rust = {
  {
    name = "Launch file",
    type = "codelldb",
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

--dap.adapters.go = {
--  type = 'server',
--  port = '${port}',
--  executable = {
--    command = 'dlv',
--    args = {'dap', '-l', '127.0.0.1:${port}'},
--  }
--}
--dap.adapters.delve = {
--  type = "server",
--  host = "127.0.0.1",
--  port = 31337,
--}
--
---- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
dap.configurations.go = {
}

require('dap.ext.vscode').load_launchjs(nil, {codelldb={'rust'}})

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
