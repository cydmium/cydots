require("globals")
require("options")
require("keymappings")

-- Plugin things
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local function is_git_repo()
  local is_repo = vim.fn.system("git rev-parse --is-inside-work-tree")
  return vim.v.shell_error == 0
end

return require("lazy").setup("plugins")
