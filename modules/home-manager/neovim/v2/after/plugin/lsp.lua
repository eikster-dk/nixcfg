local capabilities = vim.lsp.protocol.make_client_capabilities()

-- In this case, we create a function that lets us more easily define mappings specific
-- for LSP related items. It sets the mode, buffer and description for us each time.
local map = function(buf, keys, func, desc)
  vim.keymap.set("n", keys, func, { buffer = buf, desc = "LSP: " .. desc })
end

local vmap = function(buf, keys, func, desc)
  vim.keymap.set("v", keys, func, { buffer = buf, desc = "LSP: " .. desc })
end

---@param client vim.lsp.Client LSP client
---@param bufnr number Buffer number
---@diagnostic disable: unused-local
local on_attach = function(client, bufnr)
  if client.name == "gopls" and not client.server_capabilities.semanticTokensProvider then
    local semantic = client.config.capabilities.textDocument.semanticTokens
    client.server_capabilities.semanticTokensProvider = {
      full = true,
      legend = { tokenModifiers = semantic.tokenModifiers, tokenTypes = semantic.tokenTypes },
      range = true,
    }
  end

  -- Jump to the definition of the word under your cursor.
  --  This is where a variable was first declared, or where a function is defined, etc.
  --  To jump back, press <C-t>.
  map(bufnr, "gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

  -- Find references for the word under your cursor.
  map(bufnr, "gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

  -- Jump to the implementation of the word under your cursor.
  --  Useful when your language has ways of declaring types without an actual implementation.
  map(bufnr, "gi", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

  -- Jump to the type of the word under your cursor.
  --  Useful when you're not sure what type a variable is and you want to see
  --  the definition of its *type*, not where it was *defined*.
  map(bufnr, "<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

  -- Fuzzy find all the symbols in your current document.
  --  Symbols are things like variables, functions, types, etc.
  map(bufnr, "<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

  -- Fuzzy find all the symbols in your current workspace.
  --  Similar to document symbols, except searches over your entire project.
  map(bufnr, "<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

  -- Rename the variable under your cursor.
  --  Most Language Servers support renaming across files, etc.
  map(bufnr, "<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

  -- Execute a code action, usually your cursor needs to be on top of an error
  -- or a suggestion from your LSP for this to activate.
  map(bufnr, "<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
  vmap(bufnr, "<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

  -- Opens a popup that displays documentation about the word under your cursor
  --  See `:help K` for why this keymap.
  map(bufnr, "K", vim.lsp.buf.hover, "Hover Documentation")

  -- WARN: This is not Goto Definition, this is Goto Declaration.
  --  For example, in C this would take you to the header.
  map(bufnr, "gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
end

local lspconfig = require("lspconfig")

-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ";", {})
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
lspconfig.lua_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace",
      },
      telemetry = { enable = false },
      hint = {
        enable = true,
      },
    },
  },
})

lspconfig.gopls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    gopls = {
      gofumpt = true,
      codelenses = {
        gc_details = false,
        generate = true,
        run_govulncheck = true,
        test = true,
        tidy = true,
        upgrade_dependency = true,
        vendor = true,
      },
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
      analyses = {
        fieldalignment = true,
        nilness = true,
        unusedparams = true,
        unusedwrite = true,
        useany = true,
      },
      usePlaceholders = true,
      completeFunctionCalls = true,
      completeUnimported = true,
      staticcheck = true,
      directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
      semanticTokens = true,
    },
  },
})

lspconfig.golangci_lint_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig.html.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "html", "templ" },
  cmd = { "vscode-html-language-server", "--stdio" },
})

lspconfig.tailwindcss.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "templ", "javascript", "typescript", "html", "go" },
  init_options = { userLanguages = { templ = "html" } },
  settings = {
    tailwindCSS = {
      experimental = {
        classRegex = {
          { "Class(?:es)?[({]([^)}]*)[)}]", '["`]([^"`]*)["`]' },
          -- { "Class\\s*:\\s*['\"]([^'\"]*)['\"]", "class\\s*:\\s*['\"]([^'\"]*)['\"]" },
        },
      },
      includeLanguages = {
        templ = "html",
        go = "html",
      },
    },
  },
})

lspconfig.templ.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig.nil_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig.tsserver.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    javascript = {
      inlayHints = {
        includeInlayEnumMemberValueHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayVariableTypeHints = true,
      },
    },
    typescript = {
      inlayHints = {
        includeInlayEnumMemberValueHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayVariableTypeHints = true,
      },
    },
  },
})

local float_config = {
  focusable = false,
  style = "minimal",
  border = "rounded",
  source = "always",
  header = "",
  prefix = "",
}

-- setup diagnostics
vim.diagnostic.config({
  underline = true,
  update_in_insert = false,
  virtual_text = {
    spacing = 4,
    source = "if_many",
    prefix = "●",
  },
  severity_sort = true,
  float = float_config,
})

local ms = require("vim.lsp.protocol").Methods
vim.lsp.handlers[ms.textDocument_hover] = vim.lsp.with(vim.lsp.handlers.hover, float_config)
vim.lsp.handlers[ms.textDocument_signatureHelp] = vim.lsp.with(vim.lsp.handlers.signature_help, float_config)
vim.highlight.priorities.semantic_tokens = 95
