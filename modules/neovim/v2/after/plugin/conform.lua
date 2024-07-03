require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    ["javascript"] = { "prettier" },
    ["typescript"] = { "prettier" },
    templ = { "templ" },
  },
})

vim.keymap.set("n", "<leader>cf", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format document with conform" })
