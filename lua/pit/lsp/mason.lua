local status_ok, mason = pcall(require, "mason")
if not status_ok then
  print "[Error]mason not found!"
else
  -- Setup mason so it can manage external tooling
  mason.setup()
end

-- lsp signature help
local lsp_sig_ok, lsp_signature = pcall(require, "lsp_signature")
if not lsp_sig_ok then
  print "[Error]lsp_signature not found!"
  return
end

lsp_signature_cfg = {
  debug = false,
  log_path = vim.fn.stdpath "cache" .. "/lsp_signature.log",
  floating_window = false,
  hint_enable = false,
  verbose = false, -- show debug line number
  bind = true, -- This is mandatory, otherwise border config won't get registered.
  handler_opts = {
    border = "single", -- double, rounded, single, shadow, none, or a table of borders
  },
  hi_parameter = "IncSearch", -- how your parameter will be highlight

  always_trigger = false,
  toggle_key = "<M-;>",
  select_signature_key = "<M-n>",
}

local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = "LSP: " .. desc
    end

    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end

  nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
  nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

  nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
  nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
  nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
  nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
  nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
  nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

  -- See `:help K` for why this keymap
  nmap("K", vim.lsp.buf.hover, "Hover Documentation")
  nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

  -- Lesser used LSP functionality
  nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
  nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
  nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
  nmap("<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, "[W]orkspace [L]ist Folders")

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
    vim.lsp.buf.format()
  end, { desc = "Format current buffer with LSP" })
  nmap("<leader>fb", "<cmd>Format<cr>", "[F]format [B]uffer")

  -- signature help
  if lsp_sig_ok then
    lsp_signature.on_attach(lsp_signature_cfg, bufnr)
  end
end

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_ok then
  print "[Error] cmp-nvim-lsp not found!"
else
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  tflint = {
    cmd = { "tflint" },
  },
  gopls = {
    cmd = { "gopls" },
  },
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
}

local lsp_ok, lspconfig = pcall(require, "lspconfig")
if not lsp_ok then
  print "[Error]lspconfig not found!"
  return
end
local util_ok, util = pcall(require, "lspconfig.util")
if not util_ok then
  print "[Error]lspconfig.util not found!"
  return
end
-- Ensure the servers above are installed
local mason_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_ok then
  print "[Error]mason-lspconfig not found!"
else
  mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
    automatic_installation = true,
    handlers = {
      function(server_name)
        lspconfig[server_name].setup {
          capabilities = capabilities,
          on_attach = on_attach,
          settings = servers[server_name],
        }
      end,
      -- ["pylsp"] = function ()
      -- lspconfig.pylsp.setup {
      --   -- cmd = { "/Users/peterb/.pyenv/shims/pylsp"},
      --   root_dir = function(fname)
      --     local root_files = {
      --       "pyproject.toml",
      --       "setup.py",
      --       "setup.cfg",
      --       "Pipfile",
      --       "manage.py",
      --     }
      --     return util.root_pattern(unpack(root_files))(fname)
      --       or   util.find_git_ancestor(fname)
      --       or   vim.fn.expand("%:p:h")
      --   end,
      --   on_attach = on_attach,
      --   settings = {
      --     pylsp = {
      --       plugins = {
      --         black = {
      --           cache_config = true,
      --           enabled = true,
      --           line_length = 119,
      --         },
      --         flake8 = {
      --           enabled = true,
      --           maxLineLength = 119,
      --         },
      --         mypy = {
      --           enabled = true,
      --           dmypy = true,
      --         },
      --         pycodestyle = {
      --           enabled = false,
      --         },
      --         pyflakes = {
      --           enabled = false,
      --         },
      --       }
      --     }
      --   }
      -- }
      -- end,
      -- ["pyright"] = function()
      --   lspconfig.pyright.setup {
      --     -- cmd = { "/Users/peterb/.pyenv/shims/pyright", "--verbose" },
      --     root_dir = function(fname)
      --       local root_files = {
      --         "manage.py",
      --         "pyproject.toml",
      --         "setup.py",
      --         "setup.cfg",
      --         "Pipfile",
      --       }
      --       return util.root_pattern(unpack(root_files))(fname)
      --         or   util.find_git_ancestor(fname)
      --         or   vim.fn.expand("%:p:h")
      --     end,
      --     settings = {
      --       python = {
      --         analysis = {
      --           autoSearchPaths = true,
      --           typeCheckingMode = "basic",
      --           diagnosticMode = "workspace",
      --           useLibraryCodeForTypes = true,
      --           inlayHints = {
      --             variableTypes = true,
      --             functionReturnTypes = true,
      --           },
      --         },
      --       },
      --     },
      --   }
      -- end,
      ["ruff_lsp"] = lspconfig.ruff_lsp.setup {
        init_options = {
          settings = {
            args = { "--verbose" },
          },
        },
      },
    },
  }
end
vim.diagnostic.config {
  virtual_text = false,
}
