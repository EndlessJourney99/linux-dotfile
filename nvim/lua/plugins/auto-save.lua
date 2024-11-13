return {
  "pocco81/auto-save.nvim",
  lazy = true,
  event = "VeryLazy",
  config = function()
    require("auto-save").setup {
      events = { "InsertLeave" },
      execution_message = {
        message = function() -- message to print on save
          return ("")
        end,
      },
    }
  end,
}
