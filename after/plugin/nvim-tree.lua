local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  print("[Error]nvim-tree not found!")
  return
end

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then
  print("[Error]nvim-tree.config not found!")
  return
end

local icons = require "pit.icons"

local tree_cb = nvim_tree_config.nvim_tree_callback

-- local function open_nvim_tree(data)
--   local IGNORED_FT = {
--     "startify",
--     "dashboard",
--     "alpha",
--   }

--   -- buffer is a real file on the disk
--   local real_file = vim.fn.filereadable(data.file) == 1

--   -- buffer is a [No Name]
--   local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

--   -- &ft
--   local filetype = vim.bo[data.buf].ft

--   -- only files please
--   if not real_file and not no_name then
--     return
--   end

--   -- skip ignored filetypes
--   if vim.tbl_contains(IGNORED_FT, filetype) then
--     return
--   end

--   -- open the tree but don't focus it
--   require("nvim-tree.api").tree.toggle({ focus = false })
-- end

-- vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

local function on_attach(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end
  api.config.mappings.default_on_attach(bufnr)
  -- Mappings migrated from view.mappings.list
  --
  -- You will need to insert "your code goes here" for any mappings with a custom action_cb
  vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', 'o', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close Directory'))
  vim.keymap.set('n', 'v', api.node.open.vertical, opts('Open: Vertical Split'))

end

nvim_tree.setup({
  on_attach=on_attach,
  hijack_directories = {
    enable = false,
  },
  -- disable_netrw = true,
  -- hijack_netrw = true,
  filters = {
    custom = { --[[ ".git" ]] },
    exclude = { ".gitignore" },
    dotfiles = false,
  },
  -- auto_close = true,
  -- open_on_tab = false,
  -- hijack_cursor = false,
  update_cwd = false,
  sync_root_with_cwd = true,
  -- update_to_buf_dir = {
  --   enable = true,
  --   auto_open = true,
  -- },
  -- --   error
  -- --   info
  -- --   question
  -- --   warning
  -- --   lightbulb
  renderer = {
    add_trailing = false,
    group_empty = false,
    highlight_git = false,
    highlight_opened_files = "none",
    root_folder_modifier = ":t",
    indent_markers = {
      enable = false,
      icons = {
        corner = "└ ",
        edge = "│ ",
        none = "  ",
      },
    },
    icons = {
      webdev_colors = true,
      git_placement = "before",
      padding = " ",
      symlink_arrow = " ➛ ",
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
      glyphs = {
        default = "",
        symlink = "",
        folder = {
          arrow_open = icons.ui.ArrowOpen,
          arrow_closed = icons.ui.ArrowClosed,
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
        git = {
          unstaged = "",
          staged = "S",
          unmerged = "",
          renamed = "➜",
          untracked = "U",
          deleted = "",
          ignored = "◌",
        },
      },
    },
  },
  diagnostics = {
    enable = true,
    icons = {
      hint = icons.diagnostics.Hint,
      info = icons.diagnostics.Information,
      warning = icons.diagnostics.Warning,
      error = icons.diagnostics.Error,
    },
  },
  update_focused_file = {
    enable = true,
    update_cwd = false,
    update_root = false,
    ignore_list = {},
  },
  -- system_open = {
  --   cmd = nil,
  --   args = {},
  -- },
  git = {
    enable = true,
    ignore = true,
    timeout = 500,
  },
  view = {
    width = 30,
    --[[ height = 30, ]] -- deprecated
    hide_root_folder = false,
    side = "left",
    -- auto_resize = true,
    mappings = {
      custom_only = false,
      list = {
        { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
        { key = "h", cb = tree_cb "close_node" },
        { key = "v", cb = tree_cb "vsplit" },
      },
    },
    number = false,
    relativenumber = false,
  },
})
