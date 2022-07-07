local colorschemes = {
  "onedark",
  "one-nvim",
  "gruvbox",
  "gruvbox-material",
  "everforest",
  "dracula",
  "rose-pine",
  "catppuccin"
}
vim.o.termguicolors = true
if packer_plugins["onedark.nvim"] then
  require("onedark").setup {style = "dark"}
end
if packer_plugins["everforest"] then
  vim.g.everforest_better_performance = true
  vim.g.everforest_background = "medium" -- soft, medium, hard
end
if packer_plugins["gruvbox-material"] then
  vim.g.gruvbox_material_better_performance = true
  vim.g.gruvbox_material_background = "medium" -- soft, medium, hard
  vim.g.gruvbox_material_foreground = "material" -- material, mix, original
end
if packer_plugins["rose-pine"] then
  require("rose-pine").setup({dark_variant = "moon"})
end
if packer_plugins["catppuccin"] then
  vim.g.catppuccin_flavour = "frappe"
end
vim.cmd("colorscheme everforest")
