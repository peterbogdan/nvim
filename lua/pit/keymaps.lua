-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

local opts = { silent = true }

vim.keymap.set({ 'i', 't' }, 'jk', '<ESC>', opts)
vim.keymap.set({ 'i', 'n' }, "<C-c>", "<C-\\><C-N>", { noremap = true, unpack(opts) })
-- vim.keymap.set("n", "<leader>q", "q", { noremap = true, unpack(opts) })
-- vim.keymap.set("n", "q", "<nop>", { noremap = true, unpack(opts) }) -- stop recording macros everywhere
-- vim.keymap.set("n", "Q", "<nop>", { noremap = true, unpack(opts) })


vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', opts)

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, unpack(opts) })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, unpack(opts) })

-- Buffer navigation
vim.keymap.set("n", "<S-l>", ":bnext<CR>", opts)
vim.keymap.set("n", "<S-h>", ":bprevious<CR>", opts)
vim.keymap.set("n", "<leader>cc",  ":bp|bd #<CR>", opts) -- Close buffer without messing with splits

-- Search
vim.keymap.set('n', '<leader>hh', "<cmd> nohlsearch<cr>", opts)
vim.keymap.set("n", "#", "*", opts) -- hate reverse search xD
vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "Nzzzv", opts)

-- Movement
vim.keymap.set("n", "J", "mzJ`z", opts)
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)

-- Clipboard --
-- double clipboard
vim.keymap.set("x", "<leader>p", '"_dP', opts)
vim.keymap.set("n", "<leader>p", '"+p', opts)
vim.keymap.set("n", "<leader>P", '"+P', opts)
vim.keymap.set("n", "<leader>y", '"+y', opts)
vim.keymap.set("v", "<leader>y", '"+y', opts)
vim.keymap.set("n", "<leader>Y", '"+Y', opts)
vim.keymap.set({ "n", "v", "x" }, "<leader>d", [["_d]], opts)

-- Move splits quickly in normal mode
vim.keymap.set({ "n", "i" }, "<A-H>", "<Cmd>wincmd H <CR>", { silent = true })
vim.keymap.set({ "n", "i", "t" }, "<A-J>", "<Cmd>wincmd J <CR>", { silent = true })
vim.keymap.set({ "n", "i", "t" }, "<A-K>", "<Cmd>wincmd K <CR>", { silent = true })
vim.keymap.set({ "n", "i" }, "<A-L>", "<Cmd>wincmd L <CR>", { silent = true })

-- Resize splits quickly in normal mode
vim.keymap.set({ "n", "i", "t" }, "<A-=>", "<Cmd>wincmd = <CR>", { silent = true })
vim.keymap.set({ "n", "i", "t" }, "<A-+>", "<Cmd>wincmd | <CR>", { silent = true })
vim.keymap.set("n", "<m-Up>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<m-Down>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<m-Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<m-Right>", ":vertical resize +2<CR>", opts)

-- Terminal --
-- Better terminal navigation
vim.keymap.set("t", "<C-h>", "<C-\\><C-N><C-w>h", opts)
vim.keymap.set("t", "<C-j>", "<C-\\><C-N><C-w>j", opts)
vim.keymap.set("t", "<C-k>", "<C-\\><C-N><C-w>k", opts)
vim.keymap.set("t", "<C-l>", "<C-\\><C-N><C-w>l", opts)
vim.keymap.set("t", "<ESC>", "<C-\\><C-N>", opts)
vim.keymap.set("t", "jk", "<C-\\><C-N>", opts)

-- Visual --
-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Move text up and down
vim.keymap.set("v", "<S-j>", ":m .+1<CR>==", opts)
vim.keymap.set("v", "<S-k>", ":m .-2<CR>==", opts)
vim.keymap.set("v", "p", '"_dP', opts)

-- Move text up and down
vim.keymap.set("x", "J", ":move '>+1<CR>gv-gv", opts)
vim.keymap.set("x", "K", ":move '<-2<CR>gv-gv", opts)
vim.keymap.set("x", "<S-j>", ":move '>+1<CR>gv-gv", opts)
vim.keymap.set("x", "<S-k>", ":move '<-2<CR>gv-gv", opts)

-- Replace word under cursor
vim.keymap.set("n", "<leader>rw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], opts)

-- File explorer
vim.keymap.set("n", "<leader>fe", "<cmd>NvimTreeToggle<cr>", opts)

-- Quickfix movement
vim.keymap.set('n', '<leader>l', ":lopen<cr>")
vim.keymap.set('n', '<leader>L', ":lclose<cr>")
vim.keymap.set('n', '<leader>q', ":copen<cr>")
vim.keymap.set('n', '<leader>Q', ":cclose<cr>")
vim.keymap.set('n', '<leader>qn',":cn<cr>")
vim.keymap.set('n', '<leader>qp',":cp<cr>")
vim.keymap.set('n', '<leader>te',"")
vim.keymap.set('n', '<leader>tq',"")

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>te', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>tq', vim.diagnostic.setloclist)

vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)


-- debugging
vim.keymap.set("n",    "<F10>",
  [[
    <cmd>echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
  ]],
    { noremap = true, silent = false }
)
