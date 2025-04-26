return {
  "EndlessJourney99/nvim-dap-go-custom",
  config = function()
    require("dap-go").setup {
      dap_configurations = {
        -- {
        --   type = "go",
        --   name = "Debug Current Test",
        --   mode = "test",
        --   request = require("dap-go").debug_test,
        --   program = "${file}",
        -- },
      },
    }
  end,
}
