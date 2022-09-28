local dap = require("dap")
local dapui = require("dapui")
local daptext = require("nvim-dap-virtual-text")

daptext.setup()
dapui.setup({
    layouts = {
        {
            elements = {
                "console",
            },
            size = 7,
            position = "bottom",
        },
        {
            elements = {
                -- Elements can be strings or table with id and size keys.
                { id = "scopes", size = 0.25 },
                "watches",
            },
            size = 40,
            position = "left",
        }
    },
})

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

-- Update this path
local extension_path = vim.env.HOME .. '/.vscode/extensions/vadimcn.vscode-lldb-1.7.4/'
local codelldb_path = extension_path .. 'adapter/codelldb'
local liblldb_path = extension_path .. 'lldb/lib/liblldb.so'

dap.adapters.codelldb = {
  type = 'server',
  port = "${port}",
  executable = {
    -- CHANGE THIS to your path!
    command = '/usr/bin/codelldb',
    args = {"--port", "${port}"},
  }
}

dap.adapters.lldb = {
    type = 'executable',
    command = '/usr/bin/lldb-vscode',
    name = 'lldb'
}


dap.adapters.delve = {
  type = 'server',
  port = '${port}',
  executable = {
    command = 'dlv',
    args = {'dap', '-l', '127.0.0.1:${port}'},
  }
}

dap.configurations.rust = {
    {
        name = 'Launch',
        type = 'lldb',
        request = 'launch',
        program = function()
            return vim.fn.input('Path to executable: ', vim.loop.cwd() .. '/target/debug/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = true,
        args = {},

        -- 💀
        -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
        --
        --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
        --
        -- Otherwise you might get the following error:
        --
        --    Error on launch: Failed to attach to the target process
        --
        -- But you should be aware of the implications:
        -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
        -- runInTerminal = false,
    },
    {
      -- If you get an "Operation not permitted" error using this, try disabling YAMA:
      --  echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
      name = "Attach to process",
      type = 'lldb',  -- Adjust this to match your adapter name (`dap.adapters.<name>`)
      request = 'attach',
      pid = require('dap.utils').pick_process,
      args = {},
    },
}

dap.configurations.c = dap.configurations.rust
dap.configurations.cpp = dap.configurations.rust

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
  },
  {
    name= "Debug Launcherbackend",
    type= "delve",
    request= "launch",
    program= "./main.go",
    args= {
        "--client-auth",
        "--metrics-endpoint=:8013",
        "--urlsign-keyfile=${workspaceFolder}/bazel-bin/clusters/internal-dev-nl-2/k8s/launcherbackend/urlsignkey.dec",
        "--github-access-token=311b8b6c1d69f2251c448d8e9e0d09babd456951",
        "--config=${workspaceFolder}/clusters/internal-dev-nl-2/k8s/launcherbackend",
    },
  }
}


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
