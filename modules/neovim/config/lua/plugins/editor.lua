return {
  {
    "stevearc/oil.nvim",
    opts = {},
    keys = {
      { "<leader>fe", "<cmd>Oil<cr>", desc = "open oil file explorer" },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        file_ignore_patterns = {
          "*_templ.go",
        },
      },
    },
  },
}
