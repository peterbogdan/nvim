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
end, { desc = "add W to save, typoo" })

--[[ vim.api.nvim_buf_create_user_command(bufnr, "Diff", function(_)
  vim.lsp.buf.format()
end, { desc = "" }) ]]

vim.api.nvim_create_user_command("ReloadConfig", function(_)
  local ok, err = pcall(dofile, vim.env.MYVIMRC)
  if not ok then
    print("Failed to reload config: " .. err)
  else
    print("Configuration reloaded successfully!!", vim.log.levels.INFO)
  end
  for name,_ in pairs(package.loaded) do
    if name:match('^pit') and not name:match('nvim-tree') then
      package.loaded[name] = nil
      require(name)
    end
  end
end, { desc = "Reload nvim config" })

vim.api.nvim_create_user_command("CopyFilenameWithoutExtension", function(_)
  local filename = vim.fn.expand("%:t:r")
  local clip, err = io.popen('pbcopy','w')
  if clip then
    clip:write(filename)
    clip:close()
  else
    io.stderr:write("Error writing to clipboard: " .. err)
  end
end, { desc = "Copy current filename to clipboard" })

vim.api.nvim_create_user_command("BufOnly", function(_)
  --  %bd - Delete all buffers.
  --  e# - Edit the last buffer in the buffer list (which becomes the current buffer after the previous command).
  --  bd# - Delete the buffer listed before the last buffer.
  vim.cmd('%bd|e#|bd#')
end, { desc = "Close all buffers except this one" })

