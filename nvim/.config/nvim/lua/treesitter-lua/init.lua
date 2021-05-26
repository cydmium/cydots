require"nvim-treesitter.configs".setup {
  ensure_installed = {"python", "cpp", "c", "lua", "latex", "bash", "yaml", "bibtex"},
  highlight = {enable = true},
  indent = {enable = true}
}
