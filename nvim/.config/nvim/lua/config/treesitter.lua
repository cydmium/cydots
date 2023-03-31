require"nvim-treesitter.configs".setup {
  ensure_installed = {"python", "cpp", "c", "lua", "latex", "bash", "yaml", "bibtex"},
  auto_install = true,
  ignore_install = {"gitcommit"},
  highlight = {enable = true},
  indent = {enable = true},
  autopairs = {enable = true}
}
