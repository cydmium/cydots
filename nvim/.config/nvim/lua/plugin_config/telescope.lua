local actions = require("telescope.actions")

vim.keymap.set("n", "<leader>ff",
               "<cmd>lua require(\"telescope.builtin\").find_files()<cr>")
vim.keymap.set("n", "<leader>lg",
               "<cmd>lua require(\"telescope.builtin\").live_grep()<cr>")
vim.keymap.set("n", "<leader>b",
               "<cmd>lua require(\"telescope.builtin\").buffers()<cr>")
vim.keymap.set("n", "<leader>fh",
               "<cmd>lua require(\"telescope.builtin\").help_tags()<cr>")
vim.keymap.set("n", "<leader>fg",
               "<cmd>lua require(\"telescope.builtin\").git_files()<cr>")

require("telescope").setup {
  defaults = {
    mappings = {
      i = { -- Insert mode mappings
        ["<c-j>"] = actions.move_selection_next,
        ["<c-k>"] = actions.move_selection_previous,
        ["<esc>"] = actions.close,
        ["jk"] = actions.close,
        ["<cr>"] = actions.select_default + actions.center
      },
      n = { -- Normal mode mappings
        ["<c-j>"] = actions.move_selection_next,
        ["<c-k>"] = actions.move_selection_previous
      }
    }
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case" -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    }
  }
}

require("telescope").load_extension("fzf")
require("telescope").load_extension("notify")
