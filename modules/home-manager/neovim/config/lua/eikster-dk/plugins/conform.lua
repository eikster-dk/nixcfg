local conform = require("conform")
local wk = require("which-key")

conform.setup({
  formatters_by_ft = {
    lua = { "stylua" },
    nix = { "nixpkgs_fmt" },
    sql = { "pg_format" },
    templ = { "templ" },
    go = { "gofumpt" },
    ["javascript"] = { "prettier" },
    ["typescript"] = { "prettier" },
  },
})

wk.add({
  {
    "<leader>cf",
    function()
      conform.format({ async = true, lsp_fallback = true })
    end,
    mode = { "n", "v" },
    desc = "Format document with conform",
  },
})
