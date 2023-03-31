return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-buffer",
      "FelipeLema/cmp-async-path",
      "L3MON4D3/LuaSnip",
      "windwp/nvim-autopairs"
    },
    config = function()
      require("config.completion")
    end
  },
  {
    "davidsierradz/cmp-conventionalcommits",
    ft = {"gitcommit"},
    dependencies = {"hrsh7th/nvim-cmp"},
    config = function()
      require"cmp".setup.buffer {
        sources = require"cmp".config.sources({{name = "conventionalcommits"}},
                                              {{name = "buffer"}})
      }
    end
  },
  {
    "hrsh7th/cmp-git",
    ft = {"gitcommit"},
    dependencies = {"hrsh7th/nvim-cmp"},
    config = function()
      require("cmp").setup.buffer {
        sources = require("cmp").config.sources({{name = "cmp_git"}},
                                                {{name = "buffer"}})
      }
    end
  },
  {
    "f3fora/cmp-spell",
    ft = {"text", "tex", "markdown", "rst"},
    dependencies = {"hrsh7th/nvim-cmp"},
    config = function()
      require("cmp").setup({
        sources = {
          {
            name = "spell",
            option = {
              keep_all_entries = false,
              enable_in_context = function()
                return true
              end
            }
          }
        }
      })
    end
  },
  {
    "saadparwaiz1/cmp_luasnip",
    event = "InsertEnter",
    dependencies = {"hrsh7th/nvim-cmp", "L3MON4D3/LuaSnip"},
    config = function()
      local cmp = require("cmp")
      local config = cmp.get_config()
      table.insert(config.sources, {name = "luasnip"})
      cmp.setup(config)
    end
  },
  {
    "L3MON4D3/cmp-luasnip-choice",
    event = "InsertEnter",
    dependencies = {"hrsh7th/nvim-cmp", "L3MON4D3/LuaSnip"},
    config = function()
      local cmp = require("cmp")
      local config = cmp.get_config()
      table.insert(config.sources, {name = "luasnip_choice"})
      cmp.setup(config)
      require("cmp_luasnip_choice").setup({
        auto_open = true -- Automatically open nvim-cmp on choice node (default: true)
      });
    end
  },
  {
    "L3MON4D3/LuaSnip",
    event = "InsertEnter",
    config = function()
      require("config.luasnip")
    end,
    build = "make install_jsregexp" -- proper regex
  }
}
