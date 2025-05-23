-- Install packer
local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.system { "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path }
  vim.cmd [[packadd packer.nvim]]
end

require("packer").startup(function(use)
  -- Package manager
  use "wbthomason/packer.nvim"
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins

  use { "j-hui/fidget.nvim", tag = "legacy" }
  use { -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",
    requires = {
      -- Automatically install LSPs to stdpath for neovim
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",

      -- Useful status updates for LSP
      "j-hui/fidget.nvim",

      -- Additional lua configuration, makes nvim stuff amazing
      "folke/neodev.nvim",
    },
  }
  use { "ray-x/lsp_signature.nvim" } -- persist signature while typing func args
  use "jose-elias-alvarez/null-ls.nvim" -- Formatting
  use { -- Autocompletion
    "hrsh7th/nvim-cmp",
    requires = { "hrsh7th/cmp-nvim-lsp", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip", "hrsh7th/cmp-buffer" },
  }

  use { -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    tag = "v0.9.2",
    run = function()
      pcall(require("nvim-treesitter.install").update { with_sync = true })
    end,
  }

  use { -- Additional text objects via treesitter
    "nvim-treesitter/nvim-treesitter-textobjects",
    after = "nvim-treesitter",
  }

  -- Git related plugins
  use "tpope/vim-fugitive"
  use "tpope/vim-rhubarb"
  use "lewis6991/gitsigns.nvim"
  use "f-person/git-blame.nvim"
  use { "ruifm/gitlinker.nvim", requires = "nvim-lua/plenary.nvim" }
  use { "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" }

  -- UI
  use "navarasu/onedark.nvim" -- Theme inspired by Atom
  use "nvim-lualine/lualine.nvim" -- Fancier statusline
  use "akinsho/bufferline.nvim"
  use "nvim-tree/nvim-tree.lua" --

  -- Navigation
  use "ThePrimeagen/harpoon"
  -- Fuzzy Finder (files, lsp, etc)
  use { "nvim-telescope/telescope.nvim", branch = "0.1.x", requires = { "nvim-lua/plenary.nvim" } }
  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  use { "nvim-telescope/telescope-fzf-native.nvim", run = "make", cond = vim.fn.executable "make" == 1 }

  -- Debug adapter protocol
  use "mfussenegger/nvim-dap"
  use {"rcarriga/nvim-dap-ui", requires = {"nvim-neotest/nvim-nio"} }
  use "theHamsta/nvim-dap-virtual-text"
  use "nvim-telescope/telescope-dap.nvim"

  -- Testing
  use {
    "nvim-neotest/neotest",
    requires = {
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  }
  use {
    "nvim-neotest/neotest-python",
    requires = {
      "nvim-neotest/neotest",
    },
  }
  --  Adaparter configuration for specific languages
  use { "leoluz/nvim-dap-go" }
  use { "mfussenegger/nvim-dap-python" }
  use "jbyuki/one-small-step-for-vimkind"

  -- Terminal in a popup
  use { "akinsho/toggleterm.nvim", tag = "*" }

  use "lukas-reineke/indent-blankline.nvim" -- Add indentation guides even on blank lines
  use "numToStr/Comment.nvim" -- "gc" to comment visual regions/lines
  use "tpope/vim-sleuth" -- Detect tabstop and shiftwidth automatically
  use "mbbill/undotree" -- Undootree file for better undo's
  use "folke/zen-mode.nvim" -- focus only on one split
  use "windwp/nvim-spectre" -- search and replace

  -- Add custom plugins to packer from ~/.config/nvim/lua/custom/plugins.lua
  local has_plugins, plugins = pcall(require, "custom.plugins")
  if has_plugins then
    plugins(use)
  end

  if is_bootstrap then
    require("packer").sync()
  end
end)

if is_bootstrap then
  print "=================================="
  print "    Plugins are being installed"
  print "    Wait until Packer completes,"
  print "       then restart nvim"
  print "=================================="
  -- return
end
