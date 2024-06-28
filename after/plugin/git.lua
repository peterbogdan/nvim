local status_ok, gitlinker = pcall(require, "gitlinker")
if not status_ok then
  print("[Error]gitlinker not found!")
  return
end

gitlinker.setup {
  opts = {
    -- remote = 'github', -- force the use of a specific remote
    -- adds current line nr in the url for normal mode
    add_current_line_on_normal_mode = true,
    -- callback for what to do with the url
    action_callback = require("gitlinker.actions").open_in_browser,
    -- print the url after performing the action
    print_url = false,
    -- mapping to call url generation
    mappings = "<leader>gy",
  },
  callbacks = {
    ["gitlab.app.betfair"] = require("gitlinker.hosts").get_gitlab_type_url,
    ["git.comcast.com"] = require("gitlinker.hosts").get_github_type_url,
    ["github.com"] = require("gitlinker.hosts").get_github_type_url,
    ["gitlab.com"] = require("gitlinker.hosts").get_gitlab_type_url,
    ["try.gitea.io"] = require("gitlinker.hosts").get_gitea_type_url,
    ["codeberg.org"] = require("gitlinker.hosts").get_gitea_type_url,
    ["bitbucket.org"] = require("gitlinker.hosts").get_bitbucket_type_url,
    ["try.gogs.io"] = require("gitlinker.hosts").get_gogs_type_url,
    ["git.sr.ht"] = require("gitlinker.hosts").get_srht_type_url,
    ["git.launchpad.net"] = require("gitlinker.hosts").get_launchpad_type_url,
    ["rep q qo.or.cz"] = require("gitlinker.hosts").get_repoorcz_type_url,
    ["git.kernel.org"] = require("gitlinker.hosts").get_cgit_type_url,
    ["git.savannah.gnu.org"] = require("gitlinker.hosts").get_cgit_type_url,
  },
}




local status_ok, gitsigns = pcall(require, "gitsigns")
if not status_ok then
  print("[Error]gitsigns not found!")
  return
end

gitsigns.setup {
  signs = {
    add = { text = "▎" },
    change = { text = "▎" },
    delete = { text = "契" },
    topdelete = { text = "契" },
    changedelete = { text = "▎" },
  },
  signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
  numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 1000,
    follow_files = true,
  },
  attach_to_untracked = true,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
  },
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000,
  preview_config = {
    -- Options passed to nvim_open_win
    border = "rounded",
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
  },
}

vim.keymap.set('n', '<leader>gs', "<cmd> vert Git <cr>")
vim.keymap.set('n', '<leader>gd', "<cmd> Gdiffsplit <cr>")
vim.keymap.set('n', '<leader>gw', "<cmd> Gwrite <cr>")
-- vim.keymap.set('n', '<leader>gd', "<cmd> <cr>")
-- vim.keymap.set('n', '<leader>gd', "<cmd> <cr>")
