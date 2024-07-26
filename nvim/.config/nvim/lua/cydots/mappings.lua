vim.g.mapleader = " "

set("i", "jk", "<esc>")
set({ "n", "v" }, "<leader><leader>", "<cmd>nohlsearch<cr>")
set("n", "gb", "<c-^>")

-- More intuitive j/k movements
set(
  "n",
  "j",
  'v:count ? (v:count > 5 ? "m\'" . v:count : "") . "j" : "gj"',
  { expr = true, noremap = true, silent = true }
)
set(
  "n",
  "k",
  'v:count ? (v:count > 5 ? "m\'" . v:count : "") . "k" : "gk"',
  { expr = true, noremap = true, silent = true }
)
set(
  "x",
  "j",
  'v:count ? (v:count > 5 ? "m\'" . v:count : "") . "j" : "gj"',
  { expr = true, noremap = true, silent = true }
)
set(
  "x",
  "k",
  'v:count ? (v:count > 5 ? "m\'" . v:count : "") . "k" : "gk"',
  { expr = true, noremap = true, silent = true }
)

-- Let alt + hjkl control split movement
set("n", "<a-h>", "<c-w>h")
set("n", "<a-j>", "<c-w>j")
set("n", "<a-k>", "<c-w>k")
set("n", "<a-l>", "<c-w>l")

set("t", "<esc>", "<c-\\><c-n>")
set("t", "<a-h>", "<c-\\><c-n><c-w>h")
set("t", "<a-j>", "<c-\\><c-n><c-w>j")
set("t", "<a-k>", "<c-\\><c-n><c-w>k")
set("t", "<a-l>", "<c-\\><c-n><c-w>l")

set("i", "<a-h>", "<c-\\><c-n><c-w>h")
set("i", "<a-j>", "<c-\\><c-n><c-w>j")
set("i", "<a-k>", "<c-\\><c-n><c-w>k")
set("i", "<a-l>", "<c-\\><c-n><c-w>l")

-- Copy/Paste to/from system clipboard
set("n", "<leader>y", '"+y')
set("v", "<leader>y", '"+y')
set("n", "<leader>p", '"+p')
set("n", "<leader>P", '"+P')

-- Enter netrw with -
set("n", "-", vim.cmd.Ex)

-- Center screen on jumps
set("n", "<c-d>", "<c-d>zz")
set("n", "<c-u>", "<c-u>zz")
set("n", "<c-f>", "<c-f>zz")
set("n", "<c-b>", "<c-b>zz")

set("n", "Q", "<nop>")
