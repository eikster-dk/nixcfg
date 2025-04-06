local ms = require("vim.lsp.protocol").Methods
local group = vim.api.nvim_create_augroup("LSP", { clear = true })

-- Checks if the given buffer has any lsp clients that support the given method.
--
---@param bufnr number Buffer number
---@param method string Method name
---@return boolean
local has_clients_with_method = function(bufnr, method)
  local clients = vim.lsp.get_clients({ bufnr = bufnr, method = method })
  return #clients > 0
end

local m = {}

m.setup = function()
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client == nil then
        return
      end
      if client.supports_method(ms.textDocument_codeLens) then
        vim.lsp.inlay_hint.enable(true)
      end
    end,
  })

  vim.api.nvim_create_autocmd("LspDetach", {
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client == nil then
        return
      end
      if client.supports_method(ms.textDocument_codeLens) then
        vim.lsp.codelens.clear(client.id)
      end
    end,
    group = group,
  })

  vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
    callback = function()
      if has_clients_with_method(0, ms.textDocument_codeLens) then
        vim.lsp.codelens.refresh({ bufnr = 0 })
      end
    end,
    group = group,
  })

  vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    callback = function()
      if has_clients_with_method(0, ms.textDocument_documentHighlight) then
        vim.lsp.buf.document_highlight()
      end
    end,
    group = group,
  })

  vim.api.nvim_create_autocmd({ "CursorMoved" }, {
    callback = function()
      if has_clients_with_method(0, ms.textDocument_documentHighlight) then
        vim.lsp.buf.clear_references()
      end
    end,
    group = group,
  })
end

return m
