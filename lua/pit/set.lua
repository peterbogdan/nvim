-- [[ Setting options ]]
-- See `:help vim.o`

-- Search
-- Set highlight on search
vim.o.hlsearch = true
vim.opt.incsearch = true
-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true


-- Make line numbers default
vim.wo.number = true
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.colorcolumn = "80"

-- Enable mouse mode
vim.o.mouse = 'a'

-- Decrease update time
vim.opt.updatetime = 250

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

-- Set colorscheme
vim.o.termguicolors = true
vim.cmd [[colorscheme onedark]]

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect,noinsert,preview'

-- Tab/Indent settings
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- vim.cmd [[ syntax on ]]
vim.opt.syntax = "on"

vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true


