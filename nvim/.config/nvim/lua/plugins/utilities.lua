return {
  -- Optimization
  {
    "lewis6991/impatient.nvim",
    priority = 1000,
    config = function()
      require("impatient")
    end
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
      "nvim-telescope/telescope-ui-select.nvim"
    },
    config = function()
      require("config.telescope")
    end,
    cmd = "Telescope",
    module = "telescope",
    keys = {
      {"<leader>ff", "<cmd>lua require(\"telescope.builtin\").find_files()<cr>"},
      {"<leader>lg", "<cmd>lua require(\"telescope.builtin\").live_grep()<cr>"},
      {"<leader>fh", "<cmd>lua require(\"telescope.builtin\").help_tags()<cr>"},
      {"<leader>fg", "<cmd>lua require(\"telescope.builtin\").git_files()<cr>"},
      {"<leader>b", "<cmd>lua require(\"telescope.builtin\").buffers()<cr>"}
    }
  },
  {"nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true},

  -- Comment
  {
    "numToStr/Comment.nvim",
    config = function()
      require("config.comment")
    end,
    keys = {
      {"gcc"},
      {"gcO"},
      {"gco"},
      {"gck"},
      {"gcj"},
      {"gc", mode = "v"},
      {"bcc"},
      {"bck"},
      {"bcj"},
      {"bc"}
    }
  },

  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end
  }
}
