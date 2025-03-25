local wk = require("which-key")
local oil = require("oil")

oil.setup({
  view_options = {
    show_hidden = true,
  },
})

wk.add({
  {
    "<leader>fe",
    function()
      oil.open()
    end,
    desc = "Open oil file explorer (cwd)",
  },
})
