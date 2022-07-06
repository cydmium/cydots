local actions = require "lir.actions"
local mark_actions = require "lir.mark.actions"
local clipboard_actions = require "lir.clipboard.actions"

cfg = {
  show_hidden_files = false,
  devicons_enable = true,
  mappings = {
    ["l"] = actions.edit,
    ["<enter>"] = actions.edit,
    ["<C-s>"] = actions.split,
    ["<C-v>"] = actions.vsplit,
    ["<C-t>"] = actions.tabedit,

    ["h"] = actions.up,
    ["-"] = actions.up,
    ["q"] = actions.quit,

    ["K"] = actions.mkdir,
    ["d"] = actions.mkdir,
    ["n"] = actions.newfile,
    ["%"] = actions.newfile,
    ["R"] = actions.rename,
    ["@"] = actions.cd,
    ["Y"] = actions.yank_path,
    ["."] = actions.toggle_show_hidden,
    ["D"] = actions.delete,

    ["C"] = clipboard_actions.copy,
    ["X"] = clipboard_actions.cut,
    ["P"] = clipboard_actions.paste
  }
}
require"lir".setup(cfg)
vim.cmd("highlight LirDir ctermfg=109")
vim.keymap.set("n", "-", ":e %:h<cr>")
