local telescope = require("telescope")

telescope.setup({
  defaults = {
    mappings = {
      i = {
        ["<Esc>"] = require('telescope.actions').close
      },
    },
    prompt_prefix = "   ",
    selection_caret = " ❯ ",
    entry_prefix = "   ",
    multi_icon = "+ ",
    path_display = { "filename_first" },
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden",
      "--glob=!.git",
    },
  },
})

telescope.load_extension("gh")
telescope.load_extension("harpoon")

local opts = { noremap = true, silent = true }
local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", function()
  builtin.find_files({
    find_command = { "rg", "--hidden", "--files", "--smart-case", "--glob=!.git" },
  })
end, opts)

vim.keymap.set("n", "<leader>fb", builtin.buffers, opts)
vim.keymap.set("n", "<leader>fh", builtin.help_tags, opts)
vim.keymap.set("n", "<leader>fc", builtin.commands, opts)
vim.keymap.set("n", "<leader>fr", builtin.resume, opts)
vim.keymap.set("n", "<leader>fq", builtin.quickfix, opts)
vim.keymap.set("n", "<leader>lg", builtin.live_grep, opts)
vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find, opts)
vim.keymap.set("n", "<leader>xx", builtin.diagnostics, opts)
vim.keymap.set("n", "<leader>ghi", telescope.extensions.gh.issues, opts)
vim.keymap.set("n", "<leader>fj", telescope.extensions.harpoon.marks, opts)

