-- Auto install packer.nvim if not exists
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.api.nvim_command("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

vim.cmd("packadd packer.nvim")
vim.cmd("autocmd BufWritePost plugins.lua PackerCompile") -- Auto compile when there are changes in plugins.lua

return require("packer").startup(function()
  use "wbthomason/packer.nvim" -- packer manages itself

  -- LSP Helpers
  use "neovim/nvim-lspconfig"
  use "glepnir/lspsaga.nvim"
  use "ray-x/lsp_signature.nvim"
  use "kabouzeid/nvim-lspinstall"

  -- Autocompletion and Snippets
  use "hrsh7th/nvim-compe" -- autocompletion
  use "hrsh7th/vim-vsnip" -- snippet engine
  use "rafamadriz/friendly-snippets" -- default snippets

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

  -- Comments
  use "terrortylor/nvim-comment" -- gcc to comment

  -- Fuzzy Finding
  use {"nvim-telescope/telescope.nvim", requires = {{"nvim-lua/popup.nvim"}, {"nvim-lua/plenary.nvim"}}} -- Finder
  use "nvim-telescope/telescope-fzy-native.nvim" -- Fuzzy finding

  -- Better netrw
  use {"tamago324/lir.nvim", requires = {"nvim-lua/plenary.nvim"}} -- File Browser
  use "kyazdani42/nvim-web-devicons" -- devicons

  -- Indentation Highlighting
  use {"lukas-reineke/indent-blankline.nvim", branch = "lua", ft = "yaml"}

  -- Filetype specific plugins
  -- use {"lervag/vimtex", ft = "tex"} -- can't use filetype loading b/c it breaks conceal, not sure why
  use "lervag/vimtex"
end)
