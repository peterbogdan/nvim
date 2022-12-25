local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  print("[Error]telescope not found!")
  return
end
local actions = require "telescope.actions"
-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
telescope.setup {
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,

        ["<C-c>"] = actions.close,
        ["<CR>"] = actions.select_default,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,

        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
      n = {
        ["j"] = actions.move_selection_next,
        ["k"] = actions.move_selection_previous,

        ["<C-c>"] = actions.close,
        ["<CR>"] = actions.select_default,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
      },
    },
  },
  pickers = {
    find_files = {
      additional_args = function()
        return { "--hidden", "--no-ignore-global" }
      end,
    },
    live_grep = {
      additional_args = function()
        return { "--hidden", "--no-ignore-global" }
      end,
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')
--
-- Create :MultiOpen command to open multiple files at once
local M = {}
M.multi_open = function(opts)
  return require("telescope.builtin").find_files(require("telescope.themes").get_dropdown {
    find_command = opts,
    attach_mappings = function(prompt_bufnr, _)
      actions.select_default:replace(function(_)
        local state = require "telescope.actions.state"
        local picker = state.get_current_picker(prompt_bufnr)
        local multi = picker:get_multi_selection()
        local single = picker:get_selection()
        local str = ""
        if #multi > 0 then
          for _, j in pairs(multi) do
            str = str .. "edit " .. j[1] .. " | "
          end
        end
        str = str .. "edit " .. single[1]
        -- To avoid populating qf or doing ":edit! file", close the prompt first
        actions.close(prompt_bufnr)
        vim.api.nvim_command(str)
      end)
      return true
    end,
  })
end

return M
