return {
  { "williamboman/mason.nvim", lazy = true, config = true, cmd = { "Mason" } },
  { "williamboman/mason-lspconfig.nvim", lazy = true, config = true },
  { "folke/neodev.nvim", config = true, ft = { "lua" } },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    build = ":MasonToolsInstall",
    opts = {
      ensure_installed = {
        "clangd",
        "basedpyright",
        "rust-analyzer",
        "lua-language-server",
        "ruff",
        "ruff-lsp",
        "stylua",
      },
    },
    dependencies = { "williamboman/mason.nvim" },
    lazy = true,
    cmd = { "MasonToolsInstall", "MasonToolsUpdate", "MasonToolsClean" },
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("cydots.plugins.config.lspconfig")
    end,
    ft = { "lua", "python", "c", "cpp", "rust" },
  },
}
