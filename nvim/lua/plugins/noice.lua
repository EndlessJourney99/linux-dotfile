return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    messages = { view = "mini", view_warn = "mini" },
    routes = {
      {
        filter = { event = "notify", find = "No information available" },
        opts = { skip = true },
      },
      {
        filter = { event = "msg_show", find = "written" },
        opts = { skip = true },
      },
      {
        filter = { event = "notify", find = "restore" },
        opts = { skip = true },
      },
      {
        filter = { event = "notify", find = "Restore" },
        opts = { skip = true },
      },
      {
        filter = { event = "notify", find = "warning NU1903" },
        opts = { skip = true },
      },
      {
        filter = { event = "notify", find = "error NU1101" },
        opts = { skip = true },
      },
      {
        filter = { event = "notify", find = "Roslyn" },
        opts = { skip = true },
      },
      {
        filter = { event = "msg_show", find = "E315" },
        opts = { skip = true },
      },
      {
        filter = { event = "notify", find = "E315" },
        opts = { skip = true },
      },
      {
        filter = { event = "notify", find = "E5108" },
        opts = { skip = true },
      },
      {
        filter = { event = "msg_show", find = "E5108" },
        opts = { skip = true },
      },
    },
    presets = {
      lsp_doc_border = true,
    },
    lsp = {
      signature = {
        enabled = false,
      },
    },
  },
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
}
