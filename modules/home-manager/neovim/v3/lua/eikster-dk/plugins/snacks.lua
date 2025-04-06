local snacks = require("snacks")
local wk = require("which-key")

snacks.setup({
  input = { enabled = true },
  indent = { enabled = true },
  picker = { enabled = true },
})

wk.add({
  {
    "<leader>fb",
    function()
      snacks.picker.buffers()
    end,
    desc = "Buffers",
  },
  {
    "<leader>ff",
    function()
      snacks.picker.files({
        hidden = true,
      })
    end,
    desc = "Find Files",
  },
  {
    "<leader>fg",
    function()
      snacks.picker.git_files()
    end,
    desc = "Find Git Files",
  },
})
