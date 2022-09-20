local Rule = require("nvim-autopairs.rule")
local npairs = require("nvim-autopairs")

npairs.setup({
  check_ts = true,
  ts_config = {
    lua = {"string"}, -- it will not add a pair on that treesitter node
    javascript = {"template_string"},
    java = false -- don't check treesitter on java
  }
})
npairs.add_rules({
  Rule("$", "$", {"tex", "latex"}):with_move(function()
    return true
  end)
})
require("nvim-treesitter.configs").setup {autopairs = {enable = true}}

local ts_conds = require("nvim-autopairs.ts-conds")
