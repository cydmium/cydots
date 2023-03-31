return {
  -- Null-LS: Hook non-language server features into LSP protocol
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = {"nvim-lua/plenary.nvim"},
    config = function()
      require("config.null_ls")
    end,
    ft = {"lua", "python", "c", "c++", "markdown", "sh", "tex"}
  },

  -- LSP Support
  {"williamboman/mason.nvim", lazy = true},
  {"williamboman/mason-lspconfig.nvim", lazy = true},
  {"folke/neodev.nvim", ft = {"lua"}},
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/nvim-cmp"
    },
    config = function()
      require("config.lspconfig")
    end,
    ft = {"lua", "python", "c", "c++", "markdown", "sh", "tex"}
  },

  -- Vimtex for LaTeX
  {
    "lervag/vimtex",
    config = function()
      require("config.vimtex")
    end,
    ft = {"tex"}
  }
}
