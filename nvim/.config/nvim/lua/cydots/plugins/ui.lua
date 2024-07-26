return {
  -- Colorscheme
  {
    "sainnhe/everforest",
    priority = 1000,
    config = function()
      o.termguicolors = true
      g.everforest_better_performance = true
      g.everforest_background = "medium"
      vim.cmd.colorscheme("everforest")
    end,
  },

  -- Tree sitter for highlighting + code knowledge
  {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- Last release is very old
    build = ":TSUpdate",
    config = function()
      require("cydots.plugins.config.treesitter")
    end,
    event = "VeryLazy",
    lazy = vim.fn.argc(-1) == 0, -- load early if opening a file directly
  },

  {
    "windwp/nvim-autopairs",
    opts = { check_ts = true },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "InsertEnter",
  },

  {
    "RRethy/nvim-treesitter-endwise",
    config = function()
      require("nvim-treesitter.configs").setup({
        endwise = { enable = true },
      })
    end,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "InsertEnter",
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = { max_lines = 2 },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "VeryLazy",
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    config = function()
      require("nvim-treesitter.configs").setup({
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["al"] = "@loop.outer",
              ["il"] = "@loop.inner",
            },
            selection_modes = {
              ["@parameter.outer"] = "v",
              ["@function.outer"] = "V",
              ["@class.outer"] = "V",
            },
            include_surrounding_whitespace = false,
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]f"] = "@function.outer",
              ["]]"] = "@class.outer",
              ["]o"] = "@loop.outer",
              ["]j"] = "@conditional.outer",
            },
            goto_next_end = {
              ["]F"] = "@function.outer",
              ["]["] = "@class.outer",
              ["]J"] = "@conditional.outer",
            },
            goto_previous_start = {
              ["[f"] = "@function.outer",
              ["[]"] = "@class.outer",
              ["[o"] = "@loop.outer",
              ["[j"] = "@conditional.outer",
            },
            goto_previous_end = {
              ["[F"] = "@function.outer",
              ["[["] = "@class.outer",
              ["[J"] = "@conditional.outer",
            },
          },
        },
      })
    end,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "VeryLazy",
  },

  -- Easier code viewing
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
  },

  {
    "HiPhish/rainbow-delimiters.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("rainbow-delimiters")
      g.rainbow_delimiters = {
        highlight = {
          "RainbowDelimiterCyan",
          "RainbowDelimiterBlue",
          "RainbowDelimiterViolet",
          "RainbowDelimiterRed",
          "RainbowDelimiterOrange",
          "RainbowDelimiterYellow",
          "RainbowDelimiterGreen",
        },
      }
    end,
  },
}
