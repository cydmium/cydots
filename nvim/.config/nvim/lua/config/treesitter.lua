require"nvim-treesitter.configs".setup {
  ensure_installed = {"python", "cpp", "c", "lua", "latex", "bash", "yaml", "bibtex"},
  auto_install = true,
  highlight = {enable = true, disable = {"gitcommit", "fugitive"}},
  indent = {enable = true},
  autopairs = {enable = true}
}
