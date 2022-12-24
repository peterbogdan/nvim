-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
local keymap = vim.api.nvim_set_keymap -- Shorten function name

--Remap space as leader key
keymap("n", "<Space>", "", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
keymap("n", "<C-Space>", "<cmd>WhichKey \\<leader><cr>", opts)

-- Resize with arrows
keymap("n", "<m-Up>", ":resize -2<CR>", opts)
keymap("n", "<m-Down>", ":resize +2<CR>", opts)
keymap("n", "<m-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<m-Right>", ":vertical resize +2<CR>", opts)

-- Naviagate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)
keymap("i", "jj", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<S-j>", ":m .+1<CR>==", opts)
keymap("v", "<S-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<S-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<S-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
keymap("t", "<ESC>", "<C-\\><C-N>", term_opts)
keymap("t", "jk", "<C-\\><C-N>", term_opts)

keymap("n", "<leader>h", "<cmd>nohlsearch<cr>", opts)
keymap("n", "<leader>e", ":Ex<cr>", opts)
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)
keymap("n", "J", "mzJ`z", opts)
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)

keymap("n", "<tab>", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", opts)

-- double clipboard
keymap("x", "<leader>p", [["_dP]], opts)
keymap("n", "<leader>p", [["+p]], opts)
keymap("n", "<leader>P", [["+P]], opts)
keymap("n", "<leader>y", [["+y]], opts)
keymap("v", "<leader>y", [["+y]], opts)
keymap("n", "<leader>Y", [["+Y]], opts)


keymap("n", "<leader>d", [["_d]], opts)
keymap("v", "<leader>d", [["_d]], opts)

keymap("i", "<C-c>", "<Esc>", opts)

keymap("n", "Q", "<nop>", opts)

-- invert search always
keymap("n", "#", "*", opts)

keymap("n", "<leader>q",  ":bp|bd #<CR>", opts)

--vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
--vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
--vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
--vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
--[[ vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
vim.keymap.set("n", "<leader><leader>", "<cmd>source $MYVIMRC <CR>") ]]
