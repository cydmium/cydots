require("gitsigns").setup {
  numhl = false,
  linehl = false,
  keymaps = {
    -- Default keymap options
    noremap = true,
    buffer = true,

    ["n ]c"] = {expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'"},
    ["n [c"] = {expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'"},

    ["n <leader>hs"] = "<cmd>lua require\"gitsigns\".stage_hunk()<CR>",
    ["n <leader>hu"] = "<cmd>lua require\"gitsigns\".undo_stage_hunk()<CR>",
    ["n <leader>hr"] = "<cmd>lua require\"gitsigns\".reset_hunk()<CR>",
    ["n <leader>hR"] = "<cmd>lua require\"gitsigns\".reset_buffer()<CR>",
    ["n <leader>hp"] = "<cmd>lua require\"gitsigns\".preview_hunk()<CR>",
    ["n <leader>hb"] = "<cmd>lua require\"gitsigns\".blame_line(true)<CR>",

    -- Text objects
    ["o ih"] = ":<C-U>lua require\"gitsigns\".select_hunk()<CR>",
    ["x ih"] = ":<C-U>lua require\"gitsigns\".select_hunk()<CR>"
  },
  watch_gitdir = {interval = 1000, follow_files = true},
  current_line_blame = false,
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
}

