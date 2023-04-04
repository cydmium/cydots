return {
  -- Colorscheme
  {
    "sainnhe/everforest",
    lazy = false,
    config = function()
      require("colorscheme")
    end
  },

  -- Bufferline
  {
    "akinsho/bufferline.nvim",
    dependencies = {"kyazdani42/nvim-web-devicons"},
    cond = vim.fn.has("termguicolors"),
    event = "BufAdd",
    config = function()
      require("config.bufferline")
    end
  },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {"kyazdani42/nvim-web-devicons"},
    config = function()
      require("config.lualine")
    end
  },

  -- Tree-sitter for fancy highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("config.treesitter")
    end
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("config.autopairs")
    end,
    dependencies = {"nvim-treesitter/nvim-treesitter"}
  },

  {
    "RRethy/nvim-treesitter-endwise",
    event = "InsertEnter",
    config = function()
      require("config.endwise")
    end,
    dependencies = {"nvim-treesitter/nvim-treesitter"}
  },

  {
    "HiPhish/nvim-ts-rainbow2",
    event = "VeryLazy",
    config = function()
      require("config.rainbow")
    end,
    dependencies = {"nvim-treesitter/nvim-treesitter"}
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = "VeryLazy",
    config = function()
      require("config.textobjects")
    end,
    dependencies = {"nvim-treesitter/nvim-treesitter"}
  },

  -- Better netrw
  {
    "stevearc/oil.nvim",
    config = function()
      require("config.oil")
    end
  },

  -- Highlight indentation level
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
    config = function()
      require("config.blankline")
    end
  }
}
