vim.g.gitblame_enabled = 0
vim.g.gitblame_message_template = "<summary> • <date> • <author>"
vim.g.gitblame_highlight_group = "LineNr"
vim.keymap.set('n', '<leader>gl', vim.cmd.GitBlameToggle, { silent = true })
