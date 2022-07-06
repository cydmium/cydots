require"nvim-treesitter.configs".setup {
  ensure_installed = {"python", "cpp", "c", "lua", "latex", "bash", "yaml", "bibtex"},
  highlight = {enable = true, disable = {"latex"}},
  indent = {enable = true, disable = {"python"}},
  autopairs = {enable = true},
  endwise = {enable = true},
  playground = {enable = true}
}
