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

vim.api.nvim_create_user_command("TDebug", function(_)
  require("dapui").toggle()
end, { desc = "Open DAP debug ui" })

vim.api.nvim_create_user_command("TFPlan", function(_)
  local Terminal  = require('toggleterm.terminal').Terminal
  local path = vim.fn.expand("%:p:h")
  print(path)
  Terminal:new {
    cmd = "terraform init -input=false && terraform plan -out=plan.tfplan",
    direction = "tab",
    dir = path,
    close_on_exit = false,
    auto_scroll = true,
    on_close = function(_)
      vim.cmd [[tabclose]]
    end,
  }:open()
end, { desc = "Open DAP debug ui" })

vim.api.nvim_create_user_command("W", function(_)
  vim.api.nvim_command('write')
end, { desc = "Format current buffer with LSP" })

--[[ vim.api.nvim_buf_create_user_command(bufnr, "Diff", function(_)
  vim.lsp.buf.format()
end, { desc = "Format current buffer with LSP" }) ]]


vim.api.nvim_create_user_command("ReloadConfig", function(_)
  for name,_ in pairs(package.loaded) do
    if name:match('^pit') and not name:match('nvim-tree') then
      package.loaded[name] = nil
    end
  end
  dofile(vim.env.MYVIMRC)
  vim.notify("Nvim configuration reloaded!", vim.log.levels.INFO)
end, { desc = "Reload nvim config" })
