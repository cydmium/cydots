vim.keymap.set("n", "<localleader>r", ":MagmaEvaluateOperator<cr>",
               {expr = true, silent = true, noremap = true}) -- evaluate movement, ex. \raf evaluates a function
vim.keymap.set("n", "<localleader>rr", ":MagmaEvaluateLine<cr>")
vim.keymap.set("n", "<localleader>rc", ":MagmaEvaluateCell<cr>")
vim.keymap.set("n", "<localleader>rd", ":MagmaDelete<cr>")
vim.keymap.set("n", "<localleader>ro", ":MagmaShowOutput<cr>")
vim.keymap.set("v", "<localleader>r", ":<c-u>MagmaEvaluateVisual<cr>")

vim.g.magma_automatically_open_output = false
