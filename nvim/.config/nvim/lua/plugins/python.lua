return {
  -- Replaced with Iron for now
  -- {
  --   "dccsillag/magma-nvim",
  --   build = ":UpdateRemotePlugins",
  --   config = function()
  --     require("config.magma")
  --   end,
  --   ft = {"python"}
  -- },
  {"Vimjas/vim-python-pep8-indent", ft = {"python"}},
  {
    "Vigemus/iron.nvim",
    config = function()
      require("config.iron")
    end,
    ft = {"python"}
  }
}
