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
    },
    cache_picker = {num_pickers = 10},
    dynamic_preview_title = true,
    layout_strategy = "vertical",
    layout_config = {
      vertical = {width = 0.9, height = 0.9, preview_height = 0.6, preview_cutoff = 0}
    },
    path_display = {"smart", shorten = {len = 3}},
    wrap_results = true
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case" -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
    ["ui-select"] = {require("telescope.themes").get_dropdown {}}
  }
}

require("telescope").load_extension("fzf")
require("telescope").load_extension("ui-select")
