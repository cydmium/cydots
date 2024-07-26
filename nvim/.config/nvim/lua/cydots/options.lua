o.number = true
o.relativenumber = true
o.cursorline = true
o.incsearch = true
o.hlsearch = true
o.showmatch = true
o.ignorecase = true
o.smartcase = true
o.hidden = true
o.splitright = true
o.splitbelow = true
o.scrolloff = 8
o.completeopt = "menuone,noselect,noinsert"
opt.shortmess = opt.shortmess + { c = true }
api.nvim_set_option("updatetime", 300)
o.mouse = ""
g.netrw_banner = 0
bo.tabstop = 4
bo.shiftwidth = 4

create_autocmd("BufEnter", {
  desc = "Disable automatic comment insertion",
  group = create_augroup("AutoComment", {}),
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})
