vim.o.number = true -- Line Numbers
vim.o.relativenumber = true -- Relative Line Numbers
vim.o.cursorline = true -- Highlight current line
vim.o.incsearch = true -- Incremental search (search as you type)
vim.o.hlsearch = true -- Highlight matching search items
vim.o.showmatch = true -- Show match (), [], etc.
-- Ignore search case unless you use a capital letter
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hidden = true -- Allow changing buffers without saving
-- Tend to open splits towards the bottom right
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.wildmode = "longest:full" -- List all matches > complete longest > complete next full match
vim.o.scrolloff = 5 -- Maintain 5 lines above and below cusor

vim.g.python3_host_prog = "~/.pyenv/versions/tools3/bin/python"

-- Requires lir to be installed
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Allow clicking into window for focus, then enable mouse
local all_augroup = api.nvim_create_augroup("all_files", {clear = true})
api.nvim_create_autocmd({"FocusGained"}, {
  pattern = {"*"},
  command = "set mouse+=a",
  group = all_augroup
})
api.nvim_create_autocmd({"FocusLost"},
                        {pattern = {"*"}, command = "set mouse=", group = all_augroup})
