-- Setup neovim lua configuration -- before LSP!
require("neodev").setup{library = {plugins = {"nvim-dap-ui"}, types = true}}

require "pit.lsp.mason"
require "pit.lsp.cmp"
require "pit.lsp.null-ls"

-- Turn on lsp status information
require("fidget").setup()
