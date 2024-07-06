local flash = require("flash")
flash.setup({})

vim.keymap.set("n", "<leader>ls", function()
  flash.jump()
end, { desc = "Flash jump" })

vim.keymap.set("n", "<leader>lt", function()
  flash.treesitter()
end, { desc = "Flash treesitter" })

vim.keymap.set("n", "<leader>lr", function()
  flash.treesitter_search()
end, { desc = "Flash treesitter search" })
