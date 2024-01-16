return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = false,
          hide_by_name = {
            ".git",
            ".templ.go",
          },
        },
      },
      window = {
        position = "current",
      },
    },
  },
}
