local actions = require("telescope.actions")

require("telescope").setup {
  defaults = {
    mappings = {
      i = { -- Insert mode mappings
        ["<c-n>"] = actions.move_selection_next,
        ["<c-p>"] = actions.move_selection_previous,
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

if packer_plugins["which-key.nvim"] and packer_plugins["which-key.nvim"].loaded then
  wk = require("which-key")
  wk.register({
    ["<leader>"] = {
      f = {
        f = {require("telescope.builtin").find_files, "Find Files"},
        h = {require("telescope.builtin").help_tags, "Find Help"},
        g = {require("telescope.builtin").git_files, "Find Git File"},
        c = {require("telescope.builtin").commands, "Find Commands"},
        d = {require("telescope.builtin").diagnostics, "Find Diagnostics"}
      },
      l = {g = {require("telescope.builtin").live_grep, "Live Grep"}},
      b = {require("telescope.builtin").buffers, "Open Buffer"}
    }
  })
else
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
end
