local tex = {}
tex.in_mathzone = function()
  return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end

tex.in_text = function()
  return not tex.in_mathzone()
end

local create_list = function(args, snip)
  -- snip.rows will not be set by default, so handle that case.
  -- it's also the value set by the functions called from dynamic_node_external_update().
  if not snip.rows then
    snip.rows = 1
  end
  local nodes = {}
  -- keep track of which insert-index we're at.
  local ins_index = 1
  for j = 1, snip.rows do
    -- use restoreNode to not lose content when updating.
    table.insert(nodes, t("\t\\item "))
    table.insert(nodes, r(ins_index, tostring(j) .. "x1", i(1)))
    table.insert(nodes, t({"", ""}))
    ins_index = ins_index + 1
  end
  -- fix last node.
  nodes[#nodes] = t("")
  return sn(nil, nodes)
end

local function column_count_from_string(descr)
  -- this won't work for all cases, but it's simple to improve
  -- (feel free to do so! :D )
  return #(descr:gsub("[^clm]", ""))
end

-- function for the dynamicNode.
local tab = function(args, snip)
  local cols = column_count_from_string(args[1][1])
  -- snip.rows will not be set by default, so handle that case.
  -- it's also the value set by the functions called from dynamic_node_external_update().
  if not snip.rows then
    snip.rows = 1
  end
  local nodes = {}
  -- keep track of which insert-index we're at.
  local ins_indx = 1
  for j = 1, snip.rows do
    -- use restoreNode to not lose content when updating.
    table.insert(nodes, r(ins_indx, tostring(j) .. "x1", i(1)))
    ins_indx = ins_indx + 1
    for k = 2, cols do
      table.insert(nodes, t " & ")
      table.insert(nodes, r(ins_indx, tostring(j) .. "x" .. tostring(k), i(1)))
      ins_indx = ins_indx + 1
    end
    table.insert(nodes, t {"\\\\", ""})
  end
  -- fix last node.
  nodes[#nodes] = t ""
  return sn(nil, nodes)
end

local standard = {}
local auto = {}

table.insert(standard, s("ls", fmt([[
\begin{{itemize}}
{}
\end{{itemize}}
]], {
  d(1, create_list, {}, {
    user_args = {
      function(snip)
        snip.rows = snip.rows + 1
      end,
      function(snip)
        snip.rows = math.max(snip.rows - 1, 1)
      end
    }
  })
})))
table.insert(standard, s("tab", fmt([[
\begin{{tabular}}{{{}}}
{}
\end{{tabular}}
]], {
  i(1, "c"),
  d(2, tab, {1}, {
    user_args = {
      -- Pass the functions used to manually update the dynamicNode as user args.
      -- The n-th of these functions will be called by dynamic_node_external_update(n).
      -- These functions are pretty simple, there's probably some cool stuff one could do
      -- with `ui.input`
      function(snip)
        snip.rows = snip.rows + 1
      end,
      -- don't drop below one.
      function(snip)
        snip.rows = math.max(snip.rows - 1, 1)
      end
    }
  })
})))

table.insert(auto, s("dm", {t({"\\[", "\t"}), i(1), t({"", "\\]"})},
                     {condition = tex.in_text}))
table.insert(auto, s("mk", fmt("${}$", i(1)), {condition = tex.in_text}))

return standard, auto
