-- Explore:
-- - External terminal
-- - make the virt lines thing available if ppl want it
-- - find the nearest codelens above cursor

-- Must Show:
-- - Connect to an existing neovim instance, and step through some plugin
-- - Connect using configuration from VS **** json file (see if VS **** is actually just "it works" LUL)
-- - Completion in the repl, very cool for exploring objects / data

-- - Generating your own config w/ dap.run (can show rust example) (rust BTW)

local has_dap, dap = pcall(require, "dap")
if not has_dap then
  print "[Error]dap not found!"
  return
end

vim.fn.sign_define("DapBreakpoint", { text = "ß", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = "ü", texthl = "", linehl = "", numhl = "" })
-- Setup cool Among Us as avatar
vim.fn.sign_define("DapStopped", { text = "ඞ", texthl = "Error" })

require("nvim-dap-virtual-text").setup {
  enabled = true,

  -- DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, DapVirtualTextForceRefresh
  enabled_commands = false,

  -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
  highlight_changed_variables = true,
  highlight_new_as_changed = true,

  -- prefix virtual text with comment string
  commented = false,

  show_stop_reason = true,

  -- experimental features:
  virt_text_pos = "eol", -- position of virtual text, see `:h nvim_buf_set_extmark()`
  all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
}

-- DAP UI --
-- You can set trigger characters OR it will default to '.'
-- You can also trigger with the omnifunc, <c-x><c-o>
vim.cmd [[
augroup DapRepl
  au!
  au FileType dap-repl lua require('dap.ext.autocompl').attach()
augroup END
]]

local dap_ui = require "dapui"
local _ = dap_ui.setup {
  layouts = {
    {
      elements = {
        "scopes",
        "breakpoints",
        "stacks",
        "watches",
      },
      size = 50,
      position = "left",
    },
    {
      elements = {
        "console",
        "repl",
      },
      size = 15,
      position = "bottom",
    },
  },
  floating = {
    border = "single",
    mappings = {
      close = { "q", "<Esc>" }
    }
  },
}

-- TODO: How does terminal work?
--[[ dap.defaults.fallback.external_terminal = {
  command = "/home/peterb/.local/bin/zsh",
  args = { "-e" },
} ]]

-- Lua --
dap.adapters.nlua = function(callback, config)
  callback { type = "server", host = config.host, port = config.port }
end

dap.configurations.lua = {
  {
    type = "nlua",
    request = "attach",
    name = "Attach to running Neovim instance",
    host = function()
      return "127.0.0.1"
    end,
    port = function()
      -- local val = tonumber(vim.fn.input('Port: '))
      -- assert(val, "Please provide a port number")
      local val = 54231
      return val
    end,
  },
}

-- Go --
--  https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#go-using-delve-directly
dap.adapters.go = function(callback, _)
  local stdout = vim.loop.new_pipe(false)
  local handle, pid_or_err
  local port = 38697

  handle, pid_or_err = vim.loop.spawn("dlv", {
    stdio = { nil, stdout },
    args = { "dap", "-l", "127.0.0.1:" .. port },
    detached = true,
  }, function(code)
    stdout:close()
    handle:close()

    print("[delve] Exit Code:", code)
  end)

  assert(handle, "Error running dlv: " .. tostring(pid_or_err))

  stdout:read_start(function(err, chunk)
    assert(not err, err)

    if chunk then
      vim.schedule(function()
        require("dap.repl").append(chunk)
        print("[delve]", chunk)
      end)
    end
  end)

  -- Wait for delve to start
  vim.defer_fn(function()
    callback { type = "server", host = "127.0.0.1", port = port }
  end, 100)
end

dap.configurations.go = {
  {
    type = "go",
    name = "Debug (from vscode-go)",
    request = "launch",
    showLog = false,
    program = "${file}",
    dlvToolPath = vim.fn.exepath "dlv", -- Adjust to where delve is installed
  },
  {
    type = "go",
    name = "Debug (No File)",
    request = "launch",
    program = "",
  },
  {
    name = "Test Current File",
    type = "go",
    request = "launch",
    showLog = true,
    mode = "test",
    program = ".",
    dlvToolPath = vim.fn.exepath "dlv",
  },
}

-- Python --
dap.configurations.python = {}
local dap_python = require "dap-python"
dap_python.setup("~/.venvs/debugpy/bin/python", {
  -- So if configured correctly, this will open up new terminal.
  --    Could probably get this to target a particular terminal
  --    and/or add a tab to kitty or something like that as well.
  console = "externalTerminal",
  include_configs = true,
})

dap_python.test_runner = "pytest"

local pythonPath = function()
  -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
  -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
  -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
  local cwd = vim.fn.getcwd()
  local current_env = os.getenv "VIRTUAL_ENV"
  if current_env then
    return current_env .. "/bin/python"
  elseif vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
    return cwd .. "/venv/bin/python"
  elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
    return cwd .. "/.venv/bin/python"
  else
    return "python"
  end
end

local managePath = function()
  local manage = vim.fn.findfile('manage.py', '**')
  return vim.fn.getcwd() .. "/" .. manage
end,

table.insert(dap.configurations.python, {
  -- The first three options are required by nvim-dap
  type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
  request = "launch",
  name = "Django",
  program = managePath,
  pythonPath = pythonPath,
  args = { "runserver", "--noreload" },
})
table.insert(dap.configurations.python, {
  -- The first three options are required by nvim-dap
  type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
  request = "launch",
  name = "Django Command",
  program = managePath,
  pythonPath = pythonPath,
  args = function()
    return { vim.fn.expand("%:t:r"), }
  end,
})

table.insert(dap.configurations.python, {
  -- The first three options are required by nvim-dap
  type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
  request = "launch",
  name = "Django Command with args",
  program = managePath,
  pythonPath = pythonPath,
  args = function()
    local args_string = vim.fn.expand("%:t:r") .. " " .. vim.fn.input "Arguments: "
    return vim.split(args_string, " +")
  end,
})

-- Rust --
dap.configurations.rust = {
  {
    name = "Launch",
    type = "lldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = {},

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
    runInTerminal = false,
  },
  {
    name = "Launch rust-analyzer lsif",
    type = "lldb",
    request = "launch",
    program = "/home/peterb/sourcegraph/rust-analyzer.git/monikers-1/target/debug/rust-analyzer",
    args = { "lsif", "/home/peterb/build/rmpv/" },
    cwd = "/home/peterb/sourcegraph/rust-analyzer.git/monikers-1/",
    stopOnEntry = false,
    runInTerminal = false,
  },
}

-- Mappings --
local map = function(lhs, rhs, desc)
  if desc then
    desc = "[DAP] " .. desc
  end

  vim.keymap.set("n", lhs, rhs, { silent = true, desc = desc })
end

map("<leader><F5>", function()
  if vim.bo.filetype ~= "rust" then
    vim.notify "This wasn't rust. I don't know what to do"
    return
  end

  R("pit.dap").select_rust_runnable()
end)

map("<leader>dsb", dap.step_back, "step_back")
map("<leader>dsi", dap.step_into, "step_into")
map("<leader>dsov", dap.step_over, "step_over")
map("<leader>dsot", dap.step_out, "step_out")
map("<leader>dsc", dap.continue, "continue")
-- map("<leader>dvs", require("dap.ext.vscode").run_launchjs, "run vscode launch.json")
map("<leader>dui", dap_ui.toggle, "toggle dapui")

-- TODO:
-- disconnect vs. terminate

map("<leader>dr", require("dap").repl.open)

map("<leader>db", require("dap").toggle_breakpoint)
map("<leader>dB", function()
  require("dap").set_breakpoint(vim.fn.input "[DAP] Condition > ")
end)

map("<leader>de", require("dapui").eval)
map("<leader>dE", function()
  require("dapui").eval(vim.fn.input "[DAP] Expression > ")
end)

local original = {}
local debug_map = function(lhs, rhs, desc)
  local keymaps = vim.api.nvim_get_keymap "n"
  original[lhs] = vim.tbl_filter(function(v)
    return v.lhs == lhs
  end, keymaps)[1] or true

  vim.keymap.set("n", lhs, rhs, { desc = desc })
end

local debug_unmap = function()
  for k, v in pairs(original) do
    if v == true then
      vim.keymap.del("n", k)
    else
      local rhs = v.rhs

      v.lhs = nil
      v.rhs = nil
      v.buffer = nil
      v.mode = nil
      v.sid = nil
      v.lnum = nil

      vim.keymap.set("n", k, rhs, v)
    end
  end

  original = {}
end

-- dap.listeners.after.event_initialized["dapui_config"] = function()
--   debug_map("asdf", ":echo 'hello world'<CR>", "showing things")

--   dap_ui.open()
-- end

-- dap.listeners.before.event_terminated["dapui_config"] = function()
--   debug_unmap()

--   dap_ui.close()
-- end

-- dap.listeners.before.event_exited["dapui_config"] = function()
--   dap_ui.close()
-- end

local ok, dap_go = pcall(require, "dap-go")
if ok then
  dap_go.setup()
end
