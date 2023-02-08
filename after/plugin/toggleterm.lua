local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
  print("[Error]toggleterm not found!")
  return
end

toggleterm.setup {
  size = 20,
  open_mapping = [[<m-0>]],
  hide_numbers = true,
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 2,
  start_in_insert = true,
  insert_mappings = true,
  persist_size = true,
  direction = "float",
  close_on_exit = true,
  shell = vim.o.shell,
  float_opts = {
    border = "curved",
    winblend = 0,
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
}

function _G.set_terminal_keymaps()
  local opts = { noremap = true }
  vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-w>h", [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-w>j", [[<C-\><C-n><C-W>j]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-w>k", [[<C-\><C-n><C-W>k]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-w>l", [[<C-\><C-n><C-W>l]], opts)
end

vim.cmd "autocmd! TermOpen term://* lua set_terminal_keymaps()"

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new {
  hidden = true,
  cmd = "lazygit",
  direction = "tab",
  on_open = function(_)
    vim.cmd "startinsert!"
    vim.cmd "set laststatus=0"
  end,
  on_close = function(_)
    vim.cmd "set laststatus=3"
  end,
  count = 99,
}

function _LAZYGIT_TOGGLE()
  lazygit:toggle()
end

local node = Terminal:new { cmd = "node", hidden = true }

function _NODE_TOGGLE()
  node:toggle()
end

local ncdu = Terminal:new { cmd = "ncdu", hidden = true }

function _NCDU_TOGGLE()
  ncdu:toggle()
end

local htop = Terminal:new { cmd = "htop", hidden = true }

function _HTOP_TOGGLE()
  htop:toggle()
end

local python = Terminal:new { cmd = "python", hidden = true }

function _PYTHON_TOGGLE()
  python:toggle()
end

local cargo_run = Terminal:new { cmd = "cargo run", hidden = true }

function _CARGO_RUN()
  cargo_run:toggle()
end

local cargo_test = Terminal:new { cmd = "cargo test", hidden = true }

function _CARGO_TEST()
  cargo_test:toggle()
end

local float_term = Terminal:new {
  direction = "float",
  on_open = function(term)
    vim.cmd "startinsert!"
    vim.api.nvim_buf_set_keymap(
      term.bufnr,
      "n",
      "<leader>t1",
      "<cmd>1ToggleTerm direction=float<cr>",
      { noremap = true, silent = true }
    )
  end,
  count = 1,
}

function _FLOAT_TERM()
  float_term:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>tt", "<cmd>lua _FLOAT_TERM()<CR>", { noremap = true, silent = true })

local vertical_term = Terminal:new {
  direction = "vertical",
  on_open = function(term)
    vim.cmd "startinsert!"
    vim.api.nvim_buf_set_keymap(
      term.bufnr,
      "n",
      "<leader>2",
      "<cmd>2ToggleTerm size=60 direction=vertical<cr>",
      { noremap = true, silent = true }
    )
  end,
  count = 2,
}

function _VERTICAL_TERM()
  vertical_term:toggle(60)
end

vim.api.nvim_set_keymap("n", "<leader>tv", "<cmd>lua _VERTICAL_TERM()<CR>", { noremap = true, silent = true })

local horizontal_term = Terminal:new {
  direction = "horizontal",
  on_open = function(term)
    vim.cmd "startinsert!"
    vim.api.nvim_buf_set_keymap(
      term.bufnr,
      "n",
      "<leader>3",
      "<cmd>3ToggleTerm size=10 direction=horizontal<cr>",
      { noremap = true, silent = true }
    )
  end,
  count = 3,
}

function _HORIZONTAL_TERM()
  horizontal_term:toggle(10)
end

vim.api.nvim_set_keymap("n", "<leader>th", "<cmd>lua _HORIZONTAL_TERM()<CR>", { noremap = true, silent = true })

--[[
  local Terminal  = require('toggleterm.terminal').Terminal

  Terminal:new {
    cmd = string -- command to execute when creating the terminal e.g. 'top'
    direction = string -- the layout for the terminal, same as the main config options
    dir = string -- the directory for the terminal
    close_on_exit = bool -- close the terminal window when the process exits
    highlights = table -- a table with highlights
    env = table -- key:value table with environmental variables passed to jobstart()
    clear_env = bool -- use only environmental variables from `env`, passed to jobstart()
    on_open = fun(t: Terminal) -- function to run when the terminal opens
    on_close = fun(t: Terminal) -- function to run when the terminal closes
    auto_scroll = boolean -- automatically scroll to the bottom on terminal output
    -- callbacks for processing the output
    on_stdout = fun(t: Terminal, job: number, data: string[], name: string) -- callback for processing output on stdout
    on_stderr = fun(t: Terminal, job: number, data: string[], name: string) -- callback for processing output on stderr
    on_exit = fun(t: Terminal, job: number, exit_code: number, name: string) -- function to run when terminal process exits
} ]]
