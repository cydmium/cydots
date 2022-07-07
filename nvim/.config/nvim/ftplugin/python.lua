vim.bo.expandtab = true
vim.bo.shiftwidth = 4
vim.bo.softtabstop = 4
local python_augroup = api.nvim_create_augroup("python_files", {clear = true})
api.nvim_create_autocmd({"BufWritePre"}, {
  pattern = {"*.py"},
  command = [[%s/\s\+$//e]],
  group = python_augroup
})
