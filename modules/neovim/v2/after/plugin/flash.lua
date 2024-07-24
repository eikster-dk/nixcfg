local flash = require("flash")
flash.setup({})

vim.keymap.set({ "n", "x", "o" }, "<leader>ls", flash.jump, { desc = "Flash jump" })
vim.keymap.set({ "n", "x", "o" }, "<leader>lt", flash.treesitter, { desc = "Flash treesitter" })
vim.keymap.set("n", "<leader>lr", flash.treesitter_search, { desc = "Flash treesitter search" })
vim.keymap.set({ "o", "x" }, "R", flash.treesitter_search, { desc = "Treesitter Search" })
vim.keymap.set("c", "<c-s>", flash.toggle, { desc = "Toggle Flash Search" })
