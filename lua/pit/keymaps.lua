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
vim.keymap.set({ 'i', 'n', 't' }, "<C-c>", "<C-\\><C-N>", { noremap = true, unpack(opts) })
vim.keymap.set("n", "Q", "<nop>", { noremap = true, unpack(opts) })


vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', opts)

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, unpack(opts) })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, unpack(opts) })

-- Buffer navigation
vim.keymap.set("n", "<S-l>", ":bnext<CR>", opts)
vim.keymap.set("n", "<S-h>", ":bprevious<CR>", opts)

-- Search
vim.keymap.set('n', '<leader>hh', "<cmd> nohlsearch<cr>", opts)
vim.keymap.set("n", "#", "*", opts) -- hate reverse search xD

-- Clipboard --
-- double clipboard
vim.keymap.set("x", "<leader>p", '"_dP', opts)
vim.keymap.set("n", "<leader>p", '"+p', opts)
vim.keymap.set("n", "<leader>P", '"+P', opts)
vim.keymap.set("n", "<leader>y", '"+y', opts)
vim.keymap.set("v", "<leader>y", '"+y', opts)
vim.keymap.set("n", "<leader>Y", '"+Y', opts)
vim.keymap.set({ "n", "v", "x" }, "<leader>d", [["_d]], opts)

-- Resize with arrows
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

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })

vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>te', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>tq', vim.diagnostic.setloclist)

vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
vim.keymap.set('n', '<leader>gs', "<cmd> vert Git <cr>")
