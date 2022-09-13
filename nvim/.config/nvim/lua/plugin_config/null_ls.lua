local nls = require("null-ls")
local builtins = nls.builtins

local lsp_formatting = function(bufnr)
  vim.lsp.buf.format({
    filter = function(client)
      return client.name == "null-ls"
    end,
    bufnr = bufnr,
    timeout = 2000
  })
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

nls.setup {
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({group = augroup, buffer = bufnr})
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
          lsp_formatting(bufnr)
        end
      })
    end
  end,
  sources = {
    builtins.code_actions.refactoring,
    builtins.diagnostics.flake8.with({
      extra_args = {"--extend-ignore=E203", "--max-line-length=88"}
    }),
    builtins.formatting.black.with({args = {"--quiet", "-"}}),
    builtins.formatting.isort,
    builtins.diagnostics.luacheck,
    builtins.formatting.lua_format.with({
      args = {
        "-i",
        "--indent-width=2",
        "--column-limit=88",
        "--no-use-tab",
        "--no-keep-simple-function-one-line",
        "--no-keep-simple-control-block-one-line",
        "--single-quote-to-double-quote",
        "--align-table-field",
        "--align-args",
        "--chop-down-table"
      }
    }),
    builtins.formatting.clang_format
  }
}
