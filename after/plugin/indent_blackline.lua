local status_ok, indent_blankline = pcall(require, "indent_blankline")
if not status_ok then
  print("[Error]indent_blankline not found!")
  return
end
-- Enable `lukas-reineke/indent-blankline.nvim`
-- See `:help indent_blankline.txt`
require('indent_blankline').setup {
  char = '┊',
  show_trailing_blankline_indent = false,
}
