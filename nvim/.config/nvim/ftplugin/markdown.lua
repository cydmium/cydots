vim.bo.expandtab = true
vim.bo.shiftwidth = 4
vim.bo.softtabstop = 4
vim.wo.spell = true
local markdown_augroup = api.nvim_create_augroup("markdown_files", {clear = true})
api.nvim_create_autocmd({"BufWritePre"}, {
  pattern = {"*.md"},
  command = [[%s/\s\+$//e]],
  group = markdown_augroup
})
