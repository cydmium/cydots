function OpenDiagnostics()
  vim.diagnostic.open_float(nil, {
    scope = "cursor",
    focusable = false,
    close_events = {
      "CursorMoved",
      "CursorMovedI",
      "BufHidden",
      "InsertCharPre",
      "WinLeave",
    },
  })
end

create_autocmd({ "CursorHold" }, {
  pattern = "*",
  command = "lua OpenDiagnostics()",
  group = create_augroup("LSP_diagnostics", { clear = true }),
})

vim.diagnostic.config({ virtual_text = true })
require("lspconfig.ui.windows").default_options = {
  border = "rounded",
}

create_autocmd("LspAttach", {
  group = create_augroup("UserLspConfig", {}),
  callback = function(ev)
    lsp.handlers["textDocument/hover"] = lsp.with(lsp.handlers.hover, { border = "rounded" })
    lsp.handlers["textDocument/signatureHelp"] = lsp.with(lsp.handlers.signature_help, { border = "rounded" })

    -- Enable omnicomplete <c-x><c-o>
    bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    local opts = { buffer = ev.buf }
    set("n", "gd", lsp.buf.definition, opts)
    set("n", "K", lsp.buf.hover, opts)
    set("n", "<leader>rn", lsp.buf.rename, opts)
    set("n", "<leader>ca", lsp.buf.code_action, opts)
  end,
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("lspconfig")["lua_ls"].setup({
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      workspace = { checkThirdParty = false, library = vim.api.nvim_get_runtime_file("", true) },
      diagnostics = {
        disable = { "missing-fields", "missing-parameters" },
      },
    },
  },
})

require("lspconfig")["clangd"].setup({
  capabilities = capabilities,
})

require("lspconfig")["rust_analyzer"].setup({
  capabilities = capabilities,
})

require("lspconfig")["ruff_lsp"].setup({
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    capabilities = capabilities
    client.server_capabilities.hoverProvider = false
    create_autocmd("BufWritePre", {
      group = create_augroup("Ruff_LSP", { clear = true }),
      callback = function()
        lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
        vim.wait(200)
      end,
      buffer = bufnr,
    })
  end,
  init_options = {
    settings = {
      args = {
        "--ignore=F821",
      },
    },
  },
})

capabilities.textDocument.publishDiagnostics = { tagSupport = { valueSet = { 2 } } }
require("lspconfig")["basedpyright"].setup({
  capabilities = capabilities,
  settings = {
    basedpyright = {
      disableOrganizeImports = true,
      typeCheckingMode = "off",
    },
  },
})
