local lspconfig = require("lspconfig")
local blink = require("blink.cmp")
local wk = require("which-key")
local snacks = require("snacks")

local capabilities = blink.get_lsp_capabilities({
  workspace = {
    didChangeWatchedFiles = {
      dynamicRegistration = true, -- needs fswatch on linux
      relativePatternSupport = true,
    },
  },
}, true)

---@param client vim.lsp.Client LSP client
---@param bufnr number Buffer number
---@diagnostic disable: unused-local
local on_attach = function(client, bufnr)
  wk.add({
    {
      "ca",
      vim.lsp.buf.code_action,
      desc = "LSP Code Actions",
      buffer = bufnr,
    },
    {
      "gd",
      function()
        snacks.picker.lsp_definitions()
      end,
      desc = "Goto Definition",
      buffer = bufnr,
    },
    {
      "gD",
      function()
        snacks.picker.lsp_declarations()
      end,
      desc = "Goto Declaration",
      buffer = bufnr,
    },
    {
      "gr",
      function()
        snacks.picker.lsp_references()
      end,
      nowait = true,
      desc = "References",
      buffer = bufnr,
    },
    {
      "gI",
      function()
        snacks.picker.lsp_implementations()
      end,
      desc = "Goto Implementation",
      buffer = bufnr,
    },
    {
      "gy",
      function()
        snacks.picker.lsp_type_definitions()
      end,
      desc = "Goto T[y]pe Definition",
      buffer = bufnr,
    },
    {
      "<leader>ss",
      function()
        snacks.picker.lsp_symbols()
      end,
      desc = "LSP Symbols",
      buffer = bufnr,
    },
    {
      "<leader>sS",
      function()
        snacks.picker.lsp_workspace_symbols()
      end,
      desc = "LSP Workspace Symbols",
      buffer = bufnr,
    },
  })
end

-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ";", {})
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
lspconfig.lua_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      workspace = {
        checkThirdParty = false,
      },
      codeLens = {
        enable = true,
      },
      completion = {
        callSnippet = "Replace",
      },
      telemetry = { enable = false },
      doc = {
        privateName = { "^_" },
      },
      hint = {
        enable = true,
        setType = false,
        paramType = true,
        paramName = "Disable",
        semicolon = "Disable",
        arrayIndex = "Disable",
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
        gc_details = true,
        generate = true,
        run_govulncheck = true,
        test = true,
        tidy = true,
        upgrade_dependency = true,
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
        nilness = true,
        unusedparams = true,
        unusedvariable = true,
        unusedwrite = true,
        useany = true,
      },
      staticcheck = true,
      usePlaceholders = true,
      completeUnimported = true,
      directoryFilters = { "-.git", "-node_modules" },
      semanticTokens = true,
    },
  },
})

lspconfig.vtsls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
  settings = {
    complete_function_calls = true,
    vtsls = {
      enableMoveToFileCodeAction = true,
      autoUseWorkspaceTsdk = true,
      experimental = {
        maxInlayHintLength = 30,
        completion = {
          enableServerSideFuzzyMatch = true,
        },
      },
    },
    typescript = {
      updateImportsOnFileMove = { enabled = "always" },
      suggest = {
        completeFunctionCalls = true,
      },
      inlayHints = {
        enumMemberValues = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        parameterNames = { enabled = "literals" },
        parameterTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        variableTypes = { enabled = false },
      },
    },
  },
})

lspconfig.vtsls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
  settings = {
    complete_function_calls = true,
    vtsls = {
      enableMoveToFileCodeAction = true,
      autoUseWorkspaceTsdk = true,
      experimental = {
        maxInlayHintLength = 30,
        completion = {
          enableServerSideFuzzyMatch = true,
        },
      },
    },
    typescript = {
      updateImportsOnFileMove = { enabled = "always" },
      suggest = {
        completeFunctionCalls = true,
      },
      inlayHints = {
        enumMemberValues = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        parameterNames = { enabled = "literals" },
        parameterTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        variableTypes = { enabled = false },
      },
    },
  },
})

for _, lsp in ipairs({ "html" }) do
  lspconfig[lsp].setup({
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = { "html", "templ" },
  })
end

for _, lsp in ipairs({
  "nil_ls",
  "templ",
}) do
  lspconfig[lsp].setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })
end

local float_config = {
  focusable = false,
  style = "minimal",
  border = "none",
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
    -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
    -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
    -- prefix = "icons",
  },
  severity_sort = true,
  float = float_config,
})

local ms = require("vim.lsp.protocol").Methods
vim.lsp.handlers[ms.textDocument_hover] = vim.lsp.with(vim.lsp.handlers.hover, float_config)
vim.lsp.handlers[ms.textDocument_signatureHelp] = vim.lsp.with(vim.lsp.handlers.signature_help, float_config)
vim.highlight.priorities.semantic_tokens = 95

-- set up diagnostic signs
local icons = {
  Error = "",
  Warn = "",
  Info = "",
  Question = "",
  Hint = "󰌶",
  Debug = "",
  Trace = "✎",
}
for name, icon in pairs(icons) do
  name = "DiagnosticSign" .. name
  vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
end
