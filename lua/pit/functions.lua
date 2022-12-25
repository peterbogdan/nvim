-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- [[ Resize Git split window ]]
vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    vim.api.nvim_win_set_width(0, 40)
  end,
  pattern = 'fugitive',
})
