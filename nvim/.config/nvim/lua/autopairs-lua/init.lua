local npairs = require("nvim-autopairs")

npairs.setup({check_ts = true})

local ts_conds = require("nvim-autopairs.ts-conds")

-- press % => %% is only inside comment or string
npairs.add_rules({
  Rule("%", "%", "lua"):with_pair(ts_conds.is_ts_node({"string", "comment"})),
  Rule("$", "$", "lua"):with_pair(ts_conds.is_not_ts_node({"function"}))
})