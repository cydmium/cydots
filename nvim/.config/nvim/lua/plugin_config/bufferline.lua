require("bufferline").setup {}

if packer_plugins["which-key.nvim"] and packer_plugins["which-key.nvim"].loaded then
  local wk = require("which-key")
  wk.register({
    ["["] = {b = {"<cmd>BufferLineCyclePrev<cr>", "Previous Buffer"}},
    ["]"] = {b = {"<cmd>BufferLineCycleNext<cr>", "Next Buffer"}}
  })
else
  vim.keymap.set("n", "[b", ":BufferLineCyclePrev<cr>")
  vim.keymap.set("n", "]b", ":BufferLineCycleNext<cr>")
end
