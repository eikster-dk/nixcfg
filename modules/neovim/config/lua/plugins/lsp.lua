return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "css-lsp",
        "delve",
        "html-lsp",
        "stylua",
        "tailwindcss-language-server",
        "templ",
        "typescript-language-server",
      })
    end,
  },
  -- lsp servers
  {
    "neovim/nvim-lspconfig",
    opts = {
      autoformat = false,
      servers = {
        tailwindcss = {
          filetypes = {
            "templ",
            "html",
            "css",
          },
          init_options = {
            userLanguages = {
              templ = "html",
            },
          },
        },
      },
    },
  },
}
