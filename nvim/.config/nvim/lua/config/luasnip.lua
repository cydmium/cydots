-- TODO: Rewrite this whole thing
local ls = require("luasnip")
ls.config.set_config {
  history = true,
  enable_autosnippets = true,
  snip_env = {
    s = require("luasnip.nodes.snippet").S,
    sn = require("luasnip.nodes.snippet").SN,
    isn = require("luasnip.nodes.snippet").ISN,
    t = require("luasnip.nodes.textNode").T,
    f = require("luasnip.nodes.functionNode").F,
    i = require("luasnip.nodes.insertNode").I,
    c = require("luasnip.nodes.choiceNode").C,
    d = require("luasnip.nodes.dynamicNode").D,
    r = require("luasnip.nodes.restoreNode").R,
    l = require("luasnip.extras").lambda,
    rep = require("luasnip.extras").rep,
    p = require("luasnip.extras").partial,
    m = require("luasnip.extras").match,
    n = require("luasnip.extras").nonempty,
    dl = require("luasnip.extras").dynamic_lambda,
    fmt = require("luasnip.extras.fmt").fmt,
    fmta = require("luasnip.extras.fmt").fmta,
    conds = require("luasnip.extras.expand_conditions"),
    types = require("luasnip.util.types"),
    events = require("luasnip.util.events"),
    parse = require("luasnip.util.parser").parse_snippet,
    ai = require("luasnip.nodes.absolute_indexer")
  },
  updateevents = "TextChanged,TextChangedI",
  delete_check_events = "TextChanged,TextChangedI"
}
-- require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_lua").load({paths = "./snippets"})

-- Define functions for dynamically passing args to nodes
local util = require("luasnip.util.util")
local node_util = require("luasnip.nodes.util")

local function find_dynamic_node(node)
  -- the dynamicNode-key is set on snippets generated by a dynamicNode only (its'
  -- actual use is to refer to the dynamicNode that generated the snippet).
  while not node.dynamicNode do
    node = node.parent
  end
  return node.dynamicNode
end

local external_update_id = 0
-- func_indx to update the dynamicNode with different functions.
function dynamic_node_external_update(func_indx)
  -- most of this function is about restoring the cursor to the correct
  -- position+mode, the important part are the few lines from
  -- `dynamic_node.snip:store()`.

  -- find current node and the innermost dynamicNode it is inside.
  local current_node = ls.session.current_nodes[vim.api.nvim_get_current_buf()]
  local dynamic_node = find_dynamic_node(current_node)

  -- to identify current node in new snippet, if it is available.
  external_update_id = external_update_id + 1
  current_node.external_update_id = external_update_id

  -- store which mode we're in to restore later.
  local insert_pre_call = vim.fn.mode() == "i"
  -- is byte-indexed! Doesn't matter here, but important to be aware of.
  local cursor_pos_pre_relative = util.pos_sub(util.get_cursor_0ind(),
                                               current_node.mark:pos_begin_raw())

  -- store and leave current generated snippet.
  dynamic_node.snip:store()
  node_util.leave_nodes_between(dynamic_node.snip, current_node)

  -- call update-function.
  local func = dynamic_node.user_args[func_indx]
  if func then
    -- the same snippet passed to the dynamicNode-function. Any output from func
    -- should be stored in it under some unused key.
    func(dynamic_node.parent.snippet)
  end

  -- last_args is used to store the last args that were used to generate the
  -- snippet. If this function is called, these will most probably not have
  -- changed, so they are set to nil, which will force an update.
  dynamic_node.last_args = nil
  dynamic_node:update()

  -- everything below here isn't strictly necessary, but it's pretty nice to have.

  -- try to find the node we marked earlier.
  local target_node = dynamic_node:find_node(function(test_node)
    return test_node.external_update_id == external_update_id
  end)

  if target_node then
    -- the node that the cursor was in when changeChoice was called exists
    -- in the active choice! Enter it and all nodes between it and this choiceNode,
    -- then set the cursor.
    node_util.enter_nodes_between(dynamic_node, target_node)

    if insert_pre_call then
      util.set_cursor_0ind(util.pos_add(target_node.mark:pos_begin_raw(),
                                        cursor_pos_pre_relative))
    else
      node_util.select_node(target_node)
    end
    -- set the new current node correctly.
    ls.session.current_nodes[vim.api.nvim_get_current_buf()] = target_node
  else
    -- the marked node wasn't found, just jump into the new snippet noremally.
    ls.session.current_nodes[vim.api.nvim_get_current_buf()] =
        dynamic_node.snip:jump_into(1)
  end
end

-- Keybinds
vim.keymap.set("n", "<leader>s",
               "<cmd>source ~/.config/nvim/lua/plugin_config/luasnip.lua<cr>")
vim.keymap.set({"i", "s"}, "<c-l>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  elseif ls.in_snippet() then
    _G.dynamic_node_external_update(1)
  end
end)
vim.keymap.set({"i", "s"}, "<c-h>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  elseif ls.in_snippet() then
    _G.dynamic_node_external_update(2)
  end
end)

leave_snippet = function()
  local active_node = ls.session.current_nodes[api.nvim_get_current_buf()]
  if ((vim.v.event.old_mode == "s" and vim.v.event.new_mode == "n") or
      vim.v.event.old_mode == "i") and active_node and not ls.session.jump_active then
    while active_node do
      if active_node.virt_text_id then
        api.nvim_buf_del_extmark(0, ls.session.ns_id, active_node.virt_text_id)
        -- break
      end
      active_node = active_node.parent
    end
    ls.unlink_current()
  end
end

local snippet_augroup = api.nvim_create_augroup("snippets", {clear = true})
api.nvim_create_autocmd({"ModeChanged"}, {
  pattern = {"*"},
  command = "lua leave_snippet()",
  group = snippet_augroup
})
