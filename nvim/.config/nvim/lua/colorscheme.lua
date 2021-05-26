local utils = require "utils"
vim.g.gruvbox_material_enable_bold = true
vim.g.gruvbox_material_enable_italic = true
vim.g.gruvbox_material_palette = "material"
if vim.fn.has("termguicolors") == 1 then
  utils.opt("o", "termguicolors", true)
  vim.cmd("colorscheme gruvbox")
else
  vim.cmd("colorscheme gruvbox-material")
end
