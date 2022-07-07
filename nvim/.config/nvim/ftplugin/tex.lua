vim.wo.spell = true
vim.wo.conceallevel = 1
vim.bo.expandtab = true
vim.bo.shiftwidth = 4
vim.bo.softtabstop = 4
vim.keymap.set("i", "<c-l>", "<c-g>u<esc>[s1z=``a<c-g>u")
local tex_augroup = api.nvim_create_augroup("tex_files", {clear = true})
api.nvim_create_autocmd({"InsertLeave", "TextChanged"},
                        {pattern = {"*.tex"}, command = "update", group = tex_augroup})
api.nvim_create_autocmd({"VimLeave"}, {
  pattern = {"*.tex"},
  command = "!cleanLatex %",
  group = tex_augroup
})
