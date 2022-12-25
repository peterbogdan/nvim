local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  print("[Error]lualine not found!")
  return
end
-- Set lualine as statusline
-- See `:help lualine.txt`
lualine.setup {
  options = {
    icons_enabled = false,
    theme = 'onedark',
    component_separators = '|',
    section_separators = '',
  },
}
