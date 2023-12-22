return {
  "ThePrimeagen/harpoon",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = true,
  keys = {
    { "<leader>ha", "<cmd>lua require('harpoon.mark').add_file()<CR>", desc = "Mark file with harpoon" },
    { "<leader>he", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", desc = "Show harpoon marks" },
    { "<leader>h", "<cmd>lua require('harpoon.ui').nav_file(vim.v.count1)<CR>", desc = "navigate to harpoon mark " },
    { "<leader>hn", "<cmd>lua require('harpoon.ui').nav_next()<cr>", desc = "Go to next harpoon mark" },
    { "<leader>hp", "<cmd>lua require('harpoon.ui').nav_prev()<cr>", desc = "Go to previous harpoon mark" },

    { "<leader>h1", "<cmd>lua require('harpoon.ui').nav_file(1)<CR>" },
    { "<leader>h2", "<cmd>lua require('harpoon.ui').nav_file(2)<CR>" },
    { "<leader>h3", "<cmd>lua require('harpoon.ui').nav_file(3)<CR>" },
    { "<leader>h4", "<cmd>lua require('harpoon.ui').nav_file(4)<CR>" },
  },
}
