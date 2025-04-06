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
  {
    "<leader>,",
    function()
      snacks.picker.buffers()
    end,
    desc = "Buffers",
  },
  {
    "<leader>/",
    function()
      snacks.picker.grep()
    end,
    desc = "Grep",
  },
  {
    '<leader>s"',
    function()
      snacks.picker.registers()
    end,
    desc = "Registers",
  },
  {
    "<leader>sh",
    function()
      snacks.picker.help()
    end,
    desc = "Help Pages",
  },
  {
    "<leader>sq",
    function()
      snacks.picker.qflist()
    end,
    desc = "Quickfix List",
  },
  {
    "<leader>su",
    function()
      snacks.picker.undo()
    end,
    desc = "Undotree",
  },
  {
    "<leader>gl",
    function()
      snacks.lazygit.open()
    end,
    desc = "Lazygit",
  },
})
