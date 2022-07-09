local wk = require("which-key")
wk.setup {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20 -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true -- bindings for prefixed with g
    }
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  operators = {gc = "Comments"},
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+" -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>" -- binding to scroll up inside the popup
  },
  window = {
    border = "none", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = {1, 0, 1, 0}, -- extra window margin [top, right, bottom, left]
    padding = {2, 2, 2, 2}, -- extra window padding [top, right, bottom, left]
    winblend = 0
  },
  layout = {
    height = {min = 4, max = 25}, -- min and max height of the columns
    width = {min = 20, max = 50}, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "left" -- align columns left, center or right
  },
  ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
  hidden = {"<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "}, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = {"j", "k"},
    v = {"j", "k"}
  }
}

vim.g.mapleader = " " -- Use space as leader

vim.keymap.set("i", "jk", "<esc>") -- jk -> esc
vim.keymap.set({"n", "v"}, "<leader><leader>", "<cmd>nohlsearch<cr>") -- Clear highlights
wk.register({g = {b = {"<c-^>", "Go Back to previous buffer"}}})
-- vim.keymap.set( "n", "gb", "<c-^>" ) -- Go back to previous buffer

-- Make j and k move as expected when lines are wrapped
-- Function based on line number when proceeded by a count
-- Add position to jump list if moving >= 5 lines
vim.keymap.set("n", "j",
               "v:count ? (v:count > 5 ? \"m'\" . v:count : \"\") . \"j\" : \"gj\"",
               {expr = true, noremap = true, silent = true})
vim.keymap.set("n", "k",
               "v:count ? (v:count > 5 ? \"m'\" . v:count : \"\") . \"k\" : \"gk\"",
               {expr = true, noremap = true, silent = true})
vim.keymap.set("x", "j",
               "v:count ? (v:count > 5 ? \"m'\" . v:count : \"\") . \"j\" : \"gj\"",
               {expr = true, noremap = true, silent = true})
vim.keymap.set("x", "k",
               "v:count ? (v:count > 5 ? \"m'\" . v:count : \"\") . \"k\" : \"gk\"",
               {expr = true, noremap = true, silent = true})

-- Let ctrl + hjkl control split movement
vim.keymap.set("n", "<c-h>", "<c-w>h")
vim.keymap.set("n", "<c-j>", "<c-w>j")
vim.keymap.set("n", "<c-k>", "<c-w>k")
vim.keymap.set("n", "<c-l>", "<c-w>l")

-- Copy/Paste to/from system clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>p", "\"+p")
vim.keymap.set("n", "<leader>P", "\"+P")

-- Copy/Paste to/from primary selection
vim.keymap.set("n", ",y", "\"*y")
vim.keymap.set("v", ",y", "\"*y")
vim.keymap.set("n", ",p", "\"*p")
vim.keymap.set("n", ",P", "\"*P")
