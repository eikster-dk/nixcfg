local ll = require("lualine")
local noice = require("noice")

ll.setup({
  options = {
    component_separators = "",
    section_separators = "",
  },
  sections = {
    lualine_c = {
      "%=",
      {
        "filename",
        file_status = false,
        path = 1,
      },
    },
    lualine_x = {
      {
        noice.api.statusline.mode.get,
        cond = noice.api.statusline.mode.has,
        color = { fg = "#ff9e64" },
      },
    },
  },
  inactive_sections = {
    lualine_c = {
      "%=",
      {
        "filename",
        file_status = false,
        path = 1,
      },
    },
    lualine_x = { "location" },
  },
})
