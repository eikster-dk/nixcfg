require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    nix = { "nixpkgs_fmt" },
    templ = { "templ" },
    ["javascript"] = { "prettier" },
    ["typescript"] = { "prettier" },
  },
})

vim.keymap.set("n", "<leader>cf", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format document with conform" })
