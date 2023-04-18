require("neodev").setup()
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {"pyright", "lua_ls", "clangd", "texlab"},
  ui = {
    icons = {
      server_installed = "✓",
      server_pending = "➜",
      server_uninstalled = "✗"
    }
  }
})

vim.diagnostic.config({virtual_text = false})

local opts = {noremap = true, silent = true}
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = {buffer = ev.buf}
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set("n", "<space>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<space>f", function()
      vim.lsp.buf.format {async = true}
    end, opts)
  end
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("lspconfig")["pyright"].setup {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    -- Disable formatting (i.e. fallback to null-ls)
    client.server_capabilities.document_formatting = false
  end,
  settings = {
    python = {analysis = {autoImportCompletions = true, typeCheckingMode = "basic"}}
  }
}
require("lspconfig")["lua_ls"].setup {
  capabilities = capabilities,
  settings = {Lua = {workspace = {checkThirdParty = false}}}
}
require("lspconfig")["clangd"].setup {capabilities = capabilities}
require("lspconfig")["texlab"].setup {capabilities = capabilities}
