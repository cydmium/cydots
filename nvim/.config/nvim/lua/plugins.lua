-- Auto install packer.nvim if not exists
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.api.nvim_command("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

vim.cmd("packadd packer.nvim")
vim.cmd("autocmd BufWritePost plugins.lua PackerCompile") -- Auto compile when there are changes in plugins.lua

return require("packer").startup(function()
  use "wbthomason/packer.nvim" -- packer manages itself

  -- Colorscheme
  use "sainnhe/gruvbox-material" -- lower contrast version of gruvbox
  use {"npxbr/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}} -- replaces "morhetz/gruvbox"
  use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"} -- smart syntax highlighting

  -- Parenentheses, brackets, etc.
  use "windwp/nvim-autopairs" -- automatic (), [], "", etc.
  use "p00f/nvim-ts-rainbow" -- rainbow parentheses

  -- Git integration
  use "tpope/vim-fugitive" -- git command integration
  use {"lewis6991/gitsigns.nvim", requires = {"nvim-lua/plenary.nvim"}} -- show git changes in sign col

  use "terrortylor/nvim-comment" -- gcc to comment
end)
