vim.g.mapleader = " " -- Use space as leader

vim.keymap.set("i", "jk", "<esc>") -- jk -> esc
vim.keymap.set({"n", "v"}, "<leader><leader>", "<cmd>nohlsearch<cr>") -- Clear highlights
vim.keymap.set("n", "gb", "<c-^>") -- Go back to previous buffer

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

vim.keymap.set("t", "<esc>", "<c-\\><c-n>")
vim.keymap.set("t", "<c-h>", "<c-\\><c-n><c-w>h")
vim.keymap.set("t", "<c-j>", "<c-\\><c-n><c-w>j")
vim.keymap.set("t", "<c-k>", "<c-\\><c-n><c-w>k")
vim.keymap.set("t", "<c-l>", "<c-\\><c-n><c-w>l")
