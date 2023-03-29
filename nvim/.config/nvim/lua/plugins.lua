local fn = vim.fn
local install_path = DATA_PATH .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  Packer_bootstrap = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path
  })
end

local function is_git_repo()
  local is_repo = vim.fn.system("git rev-parse --is-inside-work-tree")
  return vim.v.shell_error == 0
end

return require("packer").startup(function()
  -- Packer can manage itself
  use "wbthomason/packer.nvim"

  -- Tree Sitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require("config.treesitter")
    end
  } -- smart syntax highlighting

  use {
    "windwp/nvim-autopairs",
    config = function()
      require("config.autopairs")
    end
  }

  use {
    "RRethy/nvim-treesitter-endwise",
    config = function()
      require("config.endwise")
    end
  }

  use {
    "HiPhish/nvim-ts-rainbow2",
    config = function()
      require("config.rainbow")
    end
  }

  -- Null-LS: Hook non-language server features into LSP protocol
  use {
    "jose-elias-alvarez/null-ls.nvim",
    event = "BufWinEnter",
    requires = {"nvim-lua/plenary.nvim"},
    config = function()
      require("config.null_ls")
    end
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if Packer_bootstrap then
    require("packer").sync()
  end
end)
