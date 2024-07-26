wo.spell = true
wo.conceallevel = 1
bo.expandtab = true
bo.shiftwidth = 4
bo.softtabstop = 4

set("i", "<c-s>", "<c-g>u<esc>[s1z=``a<c-g>u")

vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, { pattern = { "*.tex"}, command = "update", group = vim.api.nvim_create_augroup("tex_auto_update", { clear = true })
