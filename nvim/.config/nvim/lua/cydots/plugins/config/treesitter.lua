require("nvim-treesitter.configs").setup({
  ensure_installed = { "python", "cpp", "c", "lua", "latex", "bash", "yaml", "bibtex", "vimdoc", "rust" },
  auto_install = true,
  highlight = {
    enable = true,
    disable = { "gitcommit", "fugitive", "tex", "latex" },
    additional_vim_regex_highlighting = { "latex" },
  },
  indent = { enable = true },
})

wo.foldmethod = "expr"
wo.foldexpr = "nvim_treesitter#foldexpr()"
o.foldlevel = 99
