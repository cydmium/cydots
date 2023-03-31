return {
  {
    "ggandor/flit.nvim",
    dependencies = {"ggandor/leap.nvim", "tpope/vim-repeat"},
    config = function()
      require("flit").setup()
    end,
    keys = {{"F"}, {"f"}, {"t"}, {"T"}}
  },
  {
    "ggandor/leap.nvim",
    keys = {{"s"}, {"S"}},
    dependencies = {"ggandor/flit.nvim", "tpope/vim-repeat"},
    config = function()
      require("leap").add_default_mappings()
    end
  }
}
