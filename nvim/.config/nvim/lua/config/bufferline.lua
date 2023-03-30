require("bufferline").setup {options = {separator_style = "slant"}}

vim.keymap.set("n", "[b", ":BufferLineCyclePrev<cr>")
vim.keymap.set("n", "]b", ":BufferLineCycleNext<cr>")
