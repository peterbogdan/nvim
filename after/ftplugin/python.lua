local opts = { silent = true }

-- TODO: remove this
-- require('dap').set_log_level('TRACE')

-- vim.opt.smartindent = true -- default
vim.opt.autoindent = true
vim.o.breakindent = false
vim.o.backspace = [[indent,eol,start]]
vim.opt.syntax = "on"
vim.cmd [[ syntax on ]]

vim.api.nvim_buf_set_keymap(0, "n", "<leader>dm", "<cmd>lua require('dap-python').test_method()<cr>", opts)
vim.api.nvim_buf_set_keymap(0, "n", "<leader>dc", "<cmd>lua require('dap-python').test_class()<cr>", opts)
vim.api.nvim_buf_set_keymap(0, "v", "<leader>dx", "<cmd>lua require('dap-python').debug_selection()<cr>", opts)

