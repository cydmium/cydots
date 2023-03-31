require("bufferline").setup {
  options = {separator_style = "slant", buffer_close_icon = "", close_icon = ""}
}

vim.keymap.set("n", "[b", ":BufferLineCyclePrev<cr>")
vim.keymap.set("n", "]b", ":BufferLineCycleNext<cr>")
