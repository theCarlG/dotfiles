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

dap.adapters.delve = {
  type = 'server',
  port = '${port}',
  executable = {
    command = 'dlv',
    args = {'dap', '-l', '127.0.0.1:${port}'},
  }
}

-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
dap.configurations.go = {
  {
    type = "delve",
    name = "Debug",
    request = "launch",
    program = "${file}"
  },
  {
    type = "delve",
    name = "Debug test", -- configuration for debugging test files
    request = "launch",
    mode = "test",
    program = "${file}"
  },
  -- works with go.mod packages and sub packages 
  {
    type = "delve",
    name = "Debug test (go.mod)",
    request = "launch",
    mode = "test",
    program = "./${relativeFileDirname}"
  } 
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


local keymap = require("CarlG.utils.keymap")
local nmap = keymap.nmap

nmap('<Up>', function()
   dapui.toggle(2)
   dap.continue()
end)
nmap('<Down>', function()
   dap.step_over()
end)
nmap('<Right>', function()
   dap.step_into()
end)
nmap('<Left>', function()
   dap.step_out()
end)
nmap('<leader>db', function()
   dap.toggle_breakpoint()
end)
nmap('<leader>dc', function()
   dap.run_to_cursor()
end)
nmap('<leader>dd', function()
   dapui.toggle(1)
end)
nmap('<leader>da', function()
   dapui.toggle(2)
end)
nmap('<leader>do', function()
   dap.repl.open()
end)
nmap('<leader>dx', function()
   dap.terminate()
end)
nmap('<leader>de', function()
    dapui.eval()
end)

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
