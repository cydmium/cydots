return {
  {
    "hrsh7th/nvim-cmp",
    version = false, -- Last release is very old
    config = function()
      require("cydots.plugins.config.completion")
    end,
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
  },

  {
    "davidsierradz/cmp-conventionalcommits",
    ft = { "gitcommit" },
    dependencies = { "hrsh7th/nvim-cmp" },
    config = function()
      require("cmp").setup.buffer({
        sources = require("cmp").config.sources({ { name = "conventionalcommits" } }, { { name = "buffer" } }),
      })
    end,
  },
}
