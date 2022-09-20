local tex = {}
tex.in_mathzone = function()
  print("Function called")
  return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end

tex.in_text = function()
  return not tex.in_mathzone()
end

local at_beginning_of_line = function(line_to_cursor, trigger)
  -- Remove all whitespace
  line_to_cursor = line_to_cursor:gsub("%s+", "")
  -- Remove trigger
  line_to_cursor = line_to_cursor:sub(1, -(#trigger + 1))
  -- Check if there's anything left, i.e not first thing on the line
  if line_to_cursor == "" then
    return true
  end
  return false
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
    table.insert(nodes, t("\t"))
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

local to_deg = function(args, snip)
  local nodes = {}
  table.insert(nodes, t(snip.captures[1] .. "^{"))
  table.insert(nodes, i(1))
  table.insert(nodes, t("}"))
  return sn(nil, nodes)
end

local frac_node = function(args, snip)
  local nodes = {}
  local str = table.concat(snip.captures)
  table.insert(nodes, t("\\frac{" .. str .. "}{"))
  table.insert(nodes, i(1))
  table.insert(nodes, t("}"))
  return sn(nil, nodes)
end

local standard = {}
local auto = {}

-- Infinite list (itemize)
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
}), {condition = at_beginning_of_line}))

-- Infinite list (enumerate)
table.insert(standard, s("enum", fmt([[
\begin{{enumerate}}
{}
\end{{enumerate}}
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
}), {condition = at_beginning_of_line}))

table.insert(standard, s("tab", fmt([[
\begin{{table}}[{loc}]
    \centering
    \caption{{{caption}}}
    \label{{tab:{label}}}
    \begin{{tabular}}{{{columns}}}
{table}
    \end{{tabular}}
\end{{table}}
]], {
  loc = i(1, "htpb"),
  caption = i(2, "Caption"),
  label = i(3, "Label"),
  columns = i(4, "c"),
  table = d(5, tab, {4}, {
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
}), {condition = at_beginning_of_line}))

-- TODO: Add figure environment

-- begin statement
table.insert(standard, s("beg", fmt([[
\begin{{{}}}
    {}
\end{{{}}}
]], {i(1), i(0), rep(1)})))

-- Partial derivative
table.insert(standard,
             s("part", fmt([[\frac{{\partial {}}}{{\partial {}}}]], {i(1), i(2)}),
               {condition = tex.in_mathzone}))

-- Color
table.insert(standard,
             s("color", fmt([[\textcolor{{{}}}{{{}}}]], {i(1, "red"), i(2, "text")})))

-- Auto Snippets
-- Display Math
table.insert(auto, s("dm", {t({"\\[", "\t"}), i(1), t({"", "\\]"})},
                     {condition = tex.in_text}))

-- Inline Math
table.insert(auto, s("mk", fmt("${}$", i(1)), {condition = tex.in_text}))

-- Auto subscript
table.insert(auto, s({trig = "([A-Za-z])(%d)", regTrig = true}, f(function(args, snip)
  return snip.captures[1] .. "_" .. snip.captures[2]
end, {}), {condition = tex.in_mathzone}))

table.insert(auto,
             s({trig = "([A-Za-z])_(%d)(%d)", regTrig = true}, f(function(args, snip)
  return snip.captures[1] .. "_{" .. snip.captures[2] .. snip.captures[3] .. "}"
end, {}), {condition = tex.in_mathzone}))

-- Auto degree
table.insert(auto, s({trig = "([A-Za-z%d])td", regTrig = true}, d(1, to_deg, {}),
                     {condition = tex.in_mathzone}))

-- Auto sqrt
table.insert(auto,
             s("sqrt", fmt([[\sqrt{{{}}}]], {i(1)}), {condition = tex.in_mathzone}))

-- Auto fraction
table.insert(auto, s({trig = "(%d+)/", regTrig = true}, d(1, frac_node, {}),
                     {condition = tex.in_mathzone}))

table.insert(auto,
             s({trig = "(%d+)([A-Za-z\\]+)/", regTrig = true}, d(1, frac_node, {}),
               {condition = tex.in_mathzone}))

table.insert(auto, s("//", fmt([[\frac{{{}}}{{{}}}]], {i(1), i(2)}),
                     {condition = tex.in_mathzone}))

-- Align equal
table.insert(auto, s("==", fmt([[&= {}]], {i(1)}), {condition = tex.in_mathzone}))

-- <=, >=, ->, ~
table.insert(auto, s("<=", t("\\leq "), {condition = tex.in_mathzone}))
table.insert(auto, s(">=", t("\\geq "), {condition = tex.in_mathzone}))
table.insert(auto, s("->", t("\\to "), {condition = tex.in_mathzone}))
table.insert(auto, s("~", t("\\sim "), {condition = tex.in_mathzone}))

-- Math Caligraphy
table.insert(auto,
             s("mcal", fmt([[\mathcal{{{}}}]], {i(1)}), {condition = tex.in_mathzone}))

-- Ceil and Floor
table.insert(auto, s("ceil", fmt([[\left\lceil {} \right\rceil]], {i(1)}),
                     {condition = tex.in_mathzone}))

table.insert(auto, s("floor", fmt([[\left\lceil {} \right\rceil]], {i(1)}),
                     {condition = tex.in_mathzone}))

-- Matrices
table.insert(auto, s("bmat", fmt([[
\begin{{bmatrix}}
    {}
\end{{bmatrix}}
]], {i(1)}), {condition = tex.in_mathzone}))

table.insert(auto, s("vmat", fmt([[
\begin{{vmatrix}}
    {}
\end{{vmatrix}}
]], {i(1)}), {condition = tex.in_mathzone}))

table.insert(auto, s("mat", fmt([[
\begin{{{}}}
    {}
\end{{{}}}
]], {
  c(1,
    {t("bmatrix"), t("pmatrix"), t("vmatrix"), t("Vmatrix"), t("Bmatrix"), t("matrix")}),
  i(2),
  rep(1)
}), {condition = tex.in_mathzone}))

-- ... = \dots
table.insert(auto, s("...", t("\\dots"), {condition = tex.in_mathzone}))

-- Inverse
table.insert(auto, s("inv", t("^{{-1}}"), {condition = tex.in_mathzone}))
table.insert(auto, s({trig = "([A-Za-z])inv", regTrig = true}, f(function(args, snip)
  return snip.captures[1] .. "^{-1}"
end, {}), {condition = tex.in_mathzone}))
table.insert(auto, s({trig = "(%d)inv", regTrig = true}, f(function(args, snip)
  return snip.captures[1] .. "^{-1}"
end, {}), {condition = tex.in_mathzone}))

-- Auto xhat = \hat{x}
table.insert(auto, s({trig = "([A-Za-z])hat", regTrig = true}, f(function(args, snip)
  return "\\hat{" .. snip.captures[1] .. "}"
end, {}), {condition = tex.in_mathzone}))

-- Auto xbar = \overline{x}
table.insert(auto, s({trig = "([A-Za-z])bar", regTrig = true}, f(function(args, snip)
  return "\\overline{" .. snip.captures[1] .. "}"
end, {}), {condition = tex.in_mathzone}))

-- Auto xdot = \dot{x}
table.insert(auto, s({trig = "([A-Za-z])dot", regTrig = true}, f(function(args, snip)
  return "\\dot{" .. snip.captures[1] .. "}"
end, {}), {condition = tex.in_mathzone}))

-- Auto x,. or x., or xvec = \vec{x}
table.insert(auto, s({trig = "([A-Za-z]),.", regTrig = true}, f(function(args, snip)
  return "\\vec{" .. snip.captures[1] .. "}"
end, {}), {condition = tex.in_mathzone}))
table.insert(auto, s({trig = "([A-Za-z]).,", regTrig = true}, f(function(args, snip)
  return "\\vec{" .. snip.captures[1] .. "}"
end, {}), {condition = tex.in_mathzone}))
table.insert(auto, s({trig = "([A-Za-z])vec", regTrig = true}, f(function(args, snip)
  return "\\vec{" .. snip.captures[1] .. "}"
end, {}), {condition = tex.in_mathzone}))

-- TODO: Implement misc snippets for lim, sum, etc.

return standard, auto
