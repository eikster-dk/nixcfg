local harpoon = require("harpoon")

harpoon:setup()

vim.keymap.set("n", "<leader>ha", function()
  harpoon:list():add()
end, { desc = "Add file to Harpoon list" })

vim.keymap.set("n", "<leader>he", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Harpoon explorer" })

for i = 1, 5 do
  vim.keymap.set("n", "<leader>h" .. i, function()
    harpoon:list():select(i)
  end, { desc = "Go to harpoon file " .. i })
end

vim.keymap.set("n", "<leader>hp", function()
  harpoon:list():prev()
end, { desc = "Go to previous harpoon buffer" })

vim.keymap.set("n", "<leader>hn", function()
  harpoon:list():next()
end, { desc = "Go to next harpoon buffer" })
