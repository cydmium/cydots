local Rule = require("nvim-autopairs.rule")
local npairs = require("nvim-autopairs")

npairs.setup({check_ts = true})
npairs.add_rules({
  Rule("$", "$", {"tex", "latex"}):with_move(function()
    return true
  end)
})
require("nvim-treesitter.configs").setup {autopairs = {enable = true}}
