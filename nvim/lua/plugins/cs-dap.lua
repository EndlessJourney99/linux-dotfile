return {
  "NicholasMata/nvim-dap-cs",
  config = function()
    require("dap-cs").setup {
      -- your configuration comes here
      dap_configurations = {
        {
          -- Must be "coreclr" or it will be ignored by the plugin
          type = "coreclr",
          name = "Attach remote",
          mode = "remote",
          request = "attach",
        },
      },
      netcoredbg = {
        -- the path to the executable netcoredbg which will be used for debugging.
        -- by default, this is the "netcoredbg" executable on your PATH.
        path = "netcoredbg",
      },
    }
  end,
}
