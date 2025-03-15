return {
  "pocco81/auto-save.nvim",
  lazy = true,
  event = "VeryLazy",
  config = function()
    require("auto-save").setup {
      events = { "InsertLeave" },
      execution_message = {
        message = function() -- message to print on save
          return ""
        end,
      },
      debounce_delay = 200, -- saves the file at most every `debounce_delay` milliseconds
      callbacks = { -- functions to be executed at different intervals
        enabling = nil, -- ran when enabling auto-save
        disabling = nil, -- ran when disabling auto-save
        before_asserting_save = nil, -- ran before checking `condition`
        before_saving = nil, -- ran before doing the actual save
        after_saving = nil, -- ran after doing the actual save
      },
    }
  end,
}
