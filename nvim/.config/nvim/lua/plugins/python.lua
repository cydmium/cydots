return {
  {
    "dccsillag/magma-nvim",
    build = ":UpdateRemotePlugins",
    config = function()
      require("config.magma")
    end,
    ft = {"python"}
  }
}
