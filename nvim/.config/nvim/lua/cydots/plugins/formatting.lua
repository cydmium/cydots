return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      rust = { "rustfmt" },
    },
    format_on_save = {
      lsp_fallback = true,
      async = false,
    },
    format_after_save = {
      lsp_fallback = true,
    },
    formatters = {
      stylua = {
        args = {
          "--indent-type=Spaces",
          "--indent-width=2",
          "--search-parent-directories",
          "--stdin-filepath",
          "$FILENAME",
          "-",
        },
      },
    },
  },
  lazy = true,
  ft = { "lua", "rust" },
}
