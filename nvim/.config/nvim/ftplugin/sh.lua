vim.bo.expandtab = true
vim.bo.shiftwidth = 2
vim.bo.softtabstop = 2
local shell_augroup = api.nvim_create_augroup("shell_files", {clear = true})
api.nvim_create_autocmd({"BufWritePre"}, {
  pattern = {"*.sh"},
  command = [[%s/\s\+$//e]],
  group = shell_augroup
})
