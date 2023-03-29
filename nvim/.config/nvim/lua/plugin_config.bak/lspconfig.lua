require("nvim-lsp-installer").setup({
  ensure_installed = {"pyright", "sumneko_lua", "clangd", "texlab"},
  ui = {
    icons = {
      server_installed = "✓",
      server_pending = "➜",
      server_uninstalled = "✗"
    }
  }
})

vim.diagnostic.config({virtual_text = false})

if packer_plugins["which-key.nvim"] and packer_plugins["which-key.nvim"].loaded then
  local wk = require("which-key")
  wk.register({
    ["<leader>"] = {
      e = {vim.diagnostic.open_float, "Open diagnostic window"},
      q = {vim.diagnostic.setloclist, "Add diagnostics to location list"}
    },
    ["["] = {d = {vim.diagnostic.goto_prev, "Previous Diagnostic"}},
    ["]"] = {d = {vim.diagnostic.goto_next, "Next Diagnostic"}}
  })
else
  local opts = {noremap = true, silent = true}
  vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
  vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Disable formatting (i.e. fallback to null-ls)
  client.server_capabilities.document_formatting = false

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  if packer_plugins["which-key.nvim"] and packer_plugins["which-key.nvim"].loaded then
    local wk = require("which-key")
    wk.register({
      g = {
        name = "Goto",
        D = {vim.lsp.buf.declaration, "Goto Declaration"},
        d = {vim.lsp.buf.definition, "Goto Definition"},
        i = {vim.lsp.buf.implementation, "Goto Implementation"},
        r = {vim.lsp.buf.references, "Goto References"}
      },
      ["<leader>"] = {
        ["wa"] = {vim.lsp.buf.add_workspace_folder, "Add workspace folder"},
        ["wr"] = {vim.lsp.buf.remove_workspace_folder, "Remove workspace folder"},
        k = {vim.lsp.buf.hover, "Hover"},
        D = {vim.lsp.buf.type_definition, "Goto Type Definition"},
        ["rn"] = {vim.lsp.buf.rename, "Rename"},
        ["ca"] = {vim.lsp.buf.code_action, "Code Action"},
        f = {vim.lsp.buf.format, "Format"}
      }
    }, {mode = "n"})
    wk.register({
      g = {
        name = "Goto",
        D = {vim.lsp.buf.declaration, "Goto Declaration"},
        d = {vim.lsp.buf.definition, "Goto Definition"},
        i = {vim.lsp.buf.implementation, "Goto Implementation"},
        r = {vim.lsp.buf.references, "Goto References"}
      },
      ["<leader>"] = {
        ["wa"] = {vim.lsp.buf.add_workspace_folder, "Add workspace folder"},
        ["wr"] = {vim.lsp.buf.remove_workspace_folder, "Remove workspace folder"},
        k = {vim.lsp.buf.hover, "Hover"},
        D = {vim.lsp.buf.type_definition, "Goto Type Definition"},
        ["rn"] = {vim.lsp.buf.rename, "Rename"},
        ["ca"] = {vim.lsp.buf.code_action, "Code Action"},
        f = {vim.lsp.buf.format, "Format"}
      }
    }, {mode = "x"})
  else
    local bufopts = {noremap = true, silent = true, buffer = bufnr}
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set("n", "<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workleader_folders()))
    end, bufopts)
    vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
    vim.keymap.set("n", "<leader>f", vim.lsp.buf.formatting, bufopts)
  end
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150
}

-- Setup lspconfig.
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol
                                                                     .make_client_capabilities())

require("lspconfig")["pyright"].setup {
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities
}
require("lspconfig")["sumneko_lua"].setup {
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities
}
require("lspconfig")["clangd"].setup {
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities
}
require("lspconfig")["texlab"].setup {
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities
}
