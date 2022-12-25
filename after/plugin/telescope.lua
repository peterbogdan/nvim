local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  print("[Error]telescope not found!")
  return
end
-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
telescope.setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')
