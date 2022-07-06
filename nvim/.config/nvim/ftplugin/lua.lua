vim.bo.expandtab = true
vim.bo.shiftwidth = 2
vim.bo.softtabstop =  2
local lua_augroup = api.nvim_create_augroup("lua_files", { clear = true })
api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*.lua" },
  command = [[%s/\s\+$//e]],
  group = lua_augroup,
})
