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

  -- Colorscheme
  use {
    "sainnhe/everforest",
    config = function()
      require("colorscheme")
    end
  }

  -- Bufferline
  use {
    "akinsho/bufferline.nvim",
    requires = {"kyazdani42/nvim-web-devicons", opt = true},
    cond = vim.fn.has("termguicolors"),
    event = "BufWinEnter",
    config = function()
      require("config.bufferline")
    end
  }

  -- Statusline
  use {
    "nvim-lualine/lualine.nvim",
    requires = {"kyazdani42/nvim-web-devicons", opt = true},
    event = "VimEnter",
    config = function()
      require("config.lualine")
    end
  }

  -- Tree Sitter
  use {
    "nvim-treesitter/nvim-treesitter",
    event = "BufWinEnter",
    run = ":TSUpdate",
    config = function()
      require("config.treesitter")
    end
  } -- smart syntax highlighting

  use {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("config.autopairs")
    end
  }

  use {
    "RRethy/nvim-treesitter-endwise",
    event = "InsertEnter",
    config = function()
      require("config.endwise")
    end
  }

  use {
    "HiPhish/nvim-ts-rainbow2",
    event = "BufWinEnter",
    config = function()
      require("config.rainbow")
    end
  }

  -- Telescope
  use {
    "nvim-telescope/telescope.nvim",
    requires = {{"nvim-lua/plenary.nvim"}},
    config = function()
      require("config.telescope")
    end
  }
  use {
    "nvim-telescope/telescope-fzf-native.nvim",
    run = "make",
    requires = {{"nvim-telescope/telescope.nvim"}}
  }

  -- Comment
  use {
    "numToStr/Comment.nvim",
    config = function()
      require("config.comment")
    end,
    keys = {
      {"n", "gcc"},
      {"n", "gcO"},
      {"n", "gco"},
      {"n", "gck"},
      {"n", "gcj"},
      {"v", "gc"},
      {"n", "bcc"},
      {"n", "bck"},
      {"n", "bcj"},
      {"v", "bc"}
    }
  }

  -- Git Signs (Indicate Git changes)
  use {
    "lewis6991/gitsigns.nvim",
    cond = is_git_repo,
    config = function()
      require("config.gitsigns")
    end
    -- tag = "release" -- To use the latest release
  }

  -- Git Wrapper
  use {
    "tpope/vim-fugitive",
    cmd = {
      "G",
      "Git",
      "Gdiffsplit",
      "Gread",
      "Gwrite",
      "Ggrep",
      "GMove",
      "GDelete",
      "GBrowse",
      "GRemove",
      "GRename",
      "Glgrep",
      "Gedit"
    },
    ft = {"fugitive"}
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
