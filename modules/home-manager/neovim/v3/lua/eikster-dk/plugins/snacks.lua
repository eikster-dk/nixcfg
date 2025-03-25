local snacks = require("snacks")
local wk = require("which-key")

snacks.setup({
  input = { enabled = true },
  indent = { enabled = true },
  picker = { enabled = true },
})

wk.add({
  {
    "<leader><space>",
    function()
      snacks.picker.smart()
    end,
    desc = "Smart Find Files",
  },
})
