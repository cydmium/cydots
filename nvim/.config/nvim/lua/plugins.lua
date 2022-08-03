local fn = vim.fn
local install_path = DATA_PATH .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  local packer_bootstrap = fn.system({
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

  -- Fancy Notifications
  use {
    "rcarriga/nvim-notify",
    event = "BufWinEnter",
    config = function()
      require("plugin_config.notify")
    end
  }

  -- Which Key (Provides keymapping info)
  use {
    "max397574/which-key.nvim",
    config = function()
      require("plugin_config.whichkey")
    end
  }

  -- Tree Sitter TODO: Fix Treesitter version, requires Fedora 36
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require("plugin_config.treesitter")
    end,
    requires = {"RRethy/nvim-treesitter-endwise", "p00f/nvim-ts-rainbow"}
  } -- smart syntax highlighting

  use {"nvim-treesitter/playground", requires = {"nvim-treesitter/nvim-treesitter"}}

  -- Colorscheme
  use {"ellisonleao/gruvbox.nvim"}
  use {"sainnhe/gruvbox-material"}
  use {"Th3Whit3Wolf/one-nvim"}
  use {"sainnhe/everforest"}
  use {"dracula/vim"}
  use {"rose-pine/neovim", as = "rose-pine"}
  use {"catppuccin/nvim", as = "catppuccin"}
  use {
    "navarasu/onedark.nvim",
    config = function()
      require("colorscheme")
    end
  }

  -- Bufferline
  use {
    "akinsho/bufferline.nvim",
    requires = {"kyazdani42/nvim-web-devicons"},
    tag = "v2.*",
    cond = vim.fn.has("termguicolors"),
    event = "BufWinEnter",
    config = function()
      require("plugin_config.bufferline")
    end
  }

  -- Statusline
  use {
    "nvim-lualine/lualine.nvim",
    requires = {"kyazdani42/nvim-web-devicons", opt = true},
    config = function()
      require("plugin_config.lualine")
    end
  }

  -- Telescope
  use {
    "nvim-telescope/telescope.nvim",
    requires = {{"nvim-lua/plenary.nvim"}},
    config = function()
      require("plugin_config.telescope")
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
      require("plugin_config.comment")
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

  -- Autopairs
  use {
    "windwp/nvim-autopairs",
    config = function()
      require("plugin_config.autopairs")
    end,
    event = "InsertEnter"
  }

  -- Git Signs (Indicate Git changes)
  use {
    "lewis6991/gitsigns.nvim",
    cond = is_git_repo,
    config = function()
      require("plugin_config.gitsigns")
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

  -- Repeat more commands with .
  use {"tpope/vim-repeat"}

  use {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup {}
    end
  }

  -- Snippets
  use {
    "L3MON4D3/LuaSnip",
    config = function()
      require("plugin_config.luasnip")
    end
    -- requires = {"rafamadriz/friendly-snippets"}
  }

  -- Autocomplete
  use {
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-git",
      "hrsh7th/cmp-omni",
      "hrsh7th/cmp-nvim-lua",
      "uga-rosa/cmp-dictionary",
      "hrsh7th/cmp-calc",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip"
    },
    config = function()
      require("plugin_config.cmp")
    end
  }

  -- LSP Plugins
  use {"williamboman/nvim-lsp-installer"}
  use {
    "neovim/nvim-lspconfig",
    config = function()
      require("plugin_config.lspconfig")
    end,
    requires = {"williamboman/nvim-lsp-installer"}
  }

  -- Null-LS: Hook non-language server features into LSP protocol
  use {
    "jose-elias-alvarez/null-ls.nvim",
    event = "BufWinEnter",
    requires = {"nvim-lua/plenary.nvim"},
    config = function()
      require("plugin_config.null_ls")
    end
  }

  -- Vimtex for LaTeX
  use {
    "lervag/vimtex",
    config = function()
      require("plugin_config.vimtex")
    end,
    ft = {"tex"}
  }

  -- Refactoring Help
  use {
    "ThePrimeagen/refactoring.nvim",
    requires = {{"nvim-lua/plenary.nvim"}, {"nvim-treesitter/nvim-treesitter"}},
    config = function()
      require("refactoring").setup({})
    end
  }

  use {
    "karb94/neoscroll.nvim",
    event = "WinScrolled",
    config = function()
      require("plugin_config.neoscroll")
    end
  }

  -- Todo Quickfix/Highlights
  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup {}
    end
  }

  -- Markdown Previews
  use {"ellisonleao/glow.nvim", cmd = "Glow", run = ":GlowInstall", ft = {"markdown"}}
  use({
    "iamcco/markdown-preview.nvim",
    setup = function()
      vim.g.mkdp_filetypes = {"markdown"}
    end,
    ft = {"markdown"},
    run = function()
      vim.fn["mkdp#util#install"]()
    end
  })

  -- Better netrw
  use {
    "tamago324/lir.nvim",
    requires = {"nvim-lua/plenary.nvim", "kyazdani42/nvim-web-devicons"},
    config = function()
      require("plugin_config.lir")
    end
  }

  -- Highlight indentation level
  use {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    setup = function()
      vim.g.indentLine_enabled = 1
      vim.g.indent_blankline_char = "▏"
      vim.g.indent_blankline_filetype_exclude = {"help", "terminal", "dashboard"}
      vim.g.indent_blankline_buftype_exclude = {"terminal"}
      vim.g.indent_blankline_show_trailing_blankline_indent = false
      vim.g.indent_blankline_show_first_indent_level = false
    end,
    config = function()
      require("indent_blankline").setup {
        show_current_context = true,
        show_current_context_start = true
      }
    end
  }

  -- Fix Cursorhold Performance
  use "antoinemadec/FixCursorHold.nvim"

  -- Provide docs and things for nvim"s lua api
  use "folke/lua-dev.nvim"

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require("packer").sync()
  end
end)
