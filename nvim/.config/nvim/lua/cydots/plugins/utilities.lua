return {
  {
    "nvim-telescope/telescope.nvim",
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
          },
        },
        defaults = {
          mappings = {
            i = {
              ["<c-n>"] = require("telescope.actions").move_selection_next,
              ["<c-k>"] = require("telescope.actions").move_selection_next,
              ["<c-p>"] = require("telescope.actions").move_selection_previous,
              ["<c-j>"] = require("telescope.actions").move_selection_previous,
              ["<esc>"] = require("telescope.actions").close,
              ["jk"] = require("telescope.actions").close,
              ["<c-space>"] = require("telescope.actions").to_fuzzy_refine,
            },
          },
        },
      })
      require("telescope").load_extension("ui-select")
    end,
    keys = {
      { "<leader>ff", require("telescope.builtin").find_files },
      { "<leader>b", require("telescope.builtin").buffers },
      { "<leader>gf", require("telescope.builtin").git_files },
      { "<leader>lg", require("telescope.builtin").live_grep },
    },
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-ui-select.nvim" },
  },

  {
    "theprimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true,
    keys = {
      {
        "<leader>a",
        function()
          require("harpoon"):list():add()
        end,
      },
      {
        "<c-e>",
        function()
          require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
        end,
      },
      {
        "<c-h>",
        function()
          require("harpoon"):list():select(1)
        end,
      },
      {
        "<c-j>",
        function()
          require("harpoon"):list():select(2)
        end,
      },
      {
        "<c-k>",
        function()
          require("harpoon"):list():select(3)
        end,
      },
      {
        "<c-l>",
        function()
          require("harpoon"):list():select(4)
        end,
      },
    },
  },

  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = true,
  },

  {
    "tpope/vim-fugitive",
    config = false,
    event = "VeryLazy",
  },
}
