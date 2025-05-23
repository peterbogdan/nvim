local status_ok, neotest = pcall(require, "neotest")
if not status_ok then
  print("[Error]neotest not found!")
  return
end
neotest.setup({
  adapters = {
    require("neotest-python")({
        -- Extra arguments for nvim-dap configuration
        -- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
        -- dap = { justMyCode = false },

        -- Command line arguments for runner
        -- Can also be a function to return dynamic values
        -- args = {"--log-level", "DEBUG", "-n", "4", "--disable-warnings", "-Xfrozen_modules=off"},
        args = {"--log-level", "DEBUG", "-n", "4", "--disable-warnings"},

        -- Runner to use. Will use pytest if available by default.
        -- Can be a function to return dynamic value.
        runner = "pytest",

        -- Custom python path for the runner.
        -- Can be a string or a list of strings.
        -- Can also be a function to return dynamic value.
        -- If not provided, the path will be inferred by checking for 
        -- virtual envs in the local directory and for Pipenev/Poetry configs
        -- python = ".venv/bin/python",

        -- Returns if a given file path is a test file.
        -- NB: This function is called a lot so don't perform any heavy tasks within it.
        -- is_test_file = function(file_path)
        --   ...
        -- end,

        -- !!EXPERIMENTAL!! Enable shelling out to `pytest` to discover test
        -- instances for files containing a parametrize mark (default: false)
        -- pytest_discover_instances = true,
    })
  }
})

local map = function(lhs, rhs, desc)
  if desc then
    desc = "[neotest] " .. desc
  end

  vim.keymap.set("n", lhs, rhs, { silent = true, desc = desc })
end

map("<leader>tr", neotest.run.run, "Run")
map("<leader>trf", function () neotest.run.run(vim.fn.expand("%")) end, "Run current file")
map("<leader>trd", function () neotest.run.run({strategy = "dap"}) end, "Run debug")
map("<leader>twf", function () neotest.watch.toggle(vim.fn.expand("%")) end, "Watch current file")
map("<leader>ts", function () neotest.run.stop() end, "Stop")
