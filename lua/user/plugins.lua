local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- Deps
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins

  use "numToStr/Comment.nvim"
  use "tiagovla/scope.nvim"
  use "akinsho/bufferline.nvim"
  use "moll/vim-bbye"
  use "christianchiarulli/lualine.nvim"
  use "akinsho/toggleterm.nvim"
  use "lewis6991/impatient.nvim"
  use "lukas-reineke/indent-blankline.nvim"
  use "christianchiarulli/hop.nvim"
  -- Lua
  use {
    "abecodes/tabout.nvim",
    wants = { "nvim-treesitter" }, -- or require if not used so far
  }
  use "nacro90/numb.nvim"
  use "monaqa/dial.nvim"
  use "NvChad/nvim-colorizer.lua"
  use "windwp/nvim-spectre"
  use "kevinhwang91/nvim-bqf"
  use "ThePrimeagen/harpoon"
  use "MattesGroeger/vim-bookmarks"
  use { "michaelb/sniprun", run = "bash ./install.sh 1" }
  use {
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    ft = "markdown",
  }

  -- UI
  use "stevearc/dressing.nvim"
  use "ghillb/cybu.nvim"
  use {
    "SmiteshP/nvim-navic",
    requires = "neovim/nvim-lspconfig",
  }
  use "tversteeg/registers.nvim"
  use "rcarriga/nvim-notify"
  use "kyazdani42/nvim-web-devicons"
  use "kyazdani42/nvim-tree.lua"
  use "tamago324/lir.nvim"
  use "goolord/alpha-nvim"
  use "folke/which-key.nvim"
  use "folke/zen-mode.nvim"
  use "karb94/neoscroll.nvim"
  use "folke/todo-comments.nvim"
  use "andymass/vim-matchup"
  use "is0n/jaq-nvim"

  -- Colorschemes
  use "lunarvim/darkplus.nvim"
  use "lunarvim/onedarker.nvim"
  use "ellisonleao/gruvbox.nvim"
  use "folke/tokyonight.nvim"

  -- cmp plugins
  use { "hrsh7th/nvim-cmp" }
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-emoji"
  use "hrsh7th/cmp-nvim-lua"
  use "zbirenbaum/copilot-cmp"
  use {
    "tzachar/cmp-tabnine",
    run = "./install.sh",
    requires = "hrsh7th/nvim-cmp",
  }

  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/nvim-lsp-installer" -- simple to use language server installer
  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters
  use "simrat39/symbols-outline.nvim"
  use "ray-x/lsp_signature.nvim"
  use "b0o/SchemaStore.nvim" -- not sure
  use "folke/trouble.nvim" -- ✅
  use "j-hui/fidget.nvim" -- UI for nvim-lsp progress ✅

  -- Telescope
  use "nvim-telescope/telescope.nvim" -- ✅

  -- Treesitter
  use "nvim-treesitter/nvim-treesitter" -- ✅
  --[[ use "JoosepAlviste/nvim-ts-context-commentstring" ]] -- context commenting, don't think its needed
  --[[ use "nvim-treesitter/playground" ]] -- View treesitter information directly in Neovim!

  -- Git
  use "lewis6991/gitsigns.nvim" -- ✅
  use "f-person/git-blame.nvim" -- ✅
  use { "ruifm/gitlinker.nvim", requires = "nvim-lua/plenary.nvim" } -- ✅

  -- Create gist from vim
  --[[ use "mattn/vim-gist" ]]
  --[[ use "mattn/webapi-vim" ]]

  -- DAP
  --[[ use "mfussenegger/nvim-dap" ]]
  --[[ use "rcarriga/nvim-dap-ui" ]]

  -- Plugin Graveyard
  --[[ use "RRethy/vim-illuminate" -- highlight things under cursor ]]
  --[[ use "stevearc/aerial.nvim" ]] -- code preview for quick navigation
  --[[ use { "christianchiarulli/lsp-inlayhints.nvim", branch = "user-config" } ]]
  --[[ use "nvim-telescope/telescope-media-files.nvim" -- see images in vim ]]
  --[[ use "lalitmee/browse.nvim" -- browser/ search, not useful ]]
  --[[ use "windwp/nvim-ts-autotag" ]] -- autoclose and autorename html tag
  --[[ use "nvim-lua/popup.nvim" ]]
  --[[ use { "matbme/JABS.nvim" } ]]

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
