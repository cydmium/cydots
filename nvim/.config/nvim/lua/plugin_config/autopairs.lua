local Rule = require('nvim-autopairs.rule')
local npairs = require('nvim-autopairs')

npairs.setup({
  check_ts = true,
  ts_config = {
    lua = {'string'}, -- it will not add a pair on that treesitter node
    javascript = {'template_string'},
    java = false -- don't check treesitter on java
  }
})
-- npairs.add_rule(Rule("$", "$", "tex"))
require("nvim-treesitter.configs").setup {autopairs = {enable = true}}

local ts_conds = require('nvim-autopairs.ts-conds')
