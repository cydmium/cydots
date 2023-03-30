local function is_git_repo()
  local is_repo = vim.fn.system("git rev-parse --is-inside-work-tree")
  return vim.v.shell_error == 0
end

return {
  -- Git Signs (Indicate Git changes)
  {
    "lewis6991/gitsigns.nvim",
    cond = is_git_repo,
    config = function()
      require("config.gitsigns")
    end
    -- tag = "release" -- To use the latest release
  },

  -- Git Wrapper
  {
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
  },
}
