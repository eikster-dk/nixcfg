local harpoon = require("harpoon")
local wk = require("which-key")

harpoon:setup({
  menu = {
    width = vim.api.nvim_win_get_width(0) - 4,
  },
  settings = {
    save_on_toggle = true,
  },
})

local keys = {}
for i = 1, 5 do
  table.insert(keys, {
    "<leader>" .. i,
    function()
      harpoon:list():select(i)
    end,
    desc = "Harpoon to File " .. i,
  })
end

wk.add({
  {
    "<leader>h",
    function()
      harpoon:list():add()
    end,
    desc = "Harpoon add file",
  },
  {
    "<leader>H",
    function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end,
    desc = "Harpoon Quick Menu",
  },
  keys,
})
