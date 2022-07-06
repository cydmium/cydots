vim.o.number = true -- Line Numbers
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
vim.o.wildmode = "list:longest:full" -- List all matches > complete longest > complete next full match
vim.o.scrolloff = 5 -- Maintain 5 lines above and below cusor

vim.g.python3_host_prog = "~/.pyenv/versions/neovim/bin/python"

-- Requires lir to be installed
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
