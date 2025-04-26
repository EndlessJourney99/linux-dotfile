return {
  "mfussenegger/nvim-dap",
  dependencies = {
    {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      config = function(_, opts)
        local dap = require "dap"
        local dapui = require "dapui"
        dap.set_log_level "INFO"
        dapui.setup(opts)
        dap.listeners.after.event_initialized["dapui_config"] = function()
          dapui.open {}
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
          dapui.close {}
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
          dapui.close {}
        end
      end,
    },
    {
      "theHamsta/nvim-dap-virtual-text",
      opts = {},
    },
    {
      "jay-babu/mason-nvim-dap.nvim",
      dependencies = "mason.nvim",
      cmd = { "DapInstall", "DapUninstall" },
      opts = {
        automatic_installation = true,
        handlers = {},
        ensure_installed = {
          "delve",
        },
      },
    },
    { "jbyuki/one-small-step-for-vimkind", module = "osv" },
  },
  config = function()
    -- require("dap").adapters = {
    --   coreclr = {
    --     type = "executable",
    --     command = '/home/endless_journey/.local/share/nvim/mason/bin/netcoredbg',
    --     args = { "--interpreter=vscode" },
    --   },
    -- }
    -- require("dap").configurations = {
    --   cs = {
    --     {
    --       type = "coreclr",
    --       name = "launch - netcoredbg",
    --       request = "launch",
    --       program = function()
    --         return vim.fn.input("Path to dll", vim.fn.getcwd(), "file")
    --       end,
    --       cwd = "/",
    --       stopOnEntry = true,
    --     },
    --   },
    -- }
  end,
}
