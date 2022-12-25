local ok, harpoon = pcall(require, "harpoon")
if not ok then
  print("[Error]harpoon not found!")
  return
end

harpoon.setup {}

vim.keymap.set("n", "ma", require("harpoon.mark").add_file)
vim.keymap.set("n", "<leader>hu", require("harpoon.ui").toggle_quick_menu)

for i = 1, 5 do
  vim.keymap.set("n", string.format("<space>%s", i),
    function()
      require("harpoon.ui").nav_file(i)
    end
  )
end
