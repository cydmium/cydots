local ls = require "luasnip"

local function node_with_virtual_text(pos, node, text)
  local nodes
  if node.type == types.textNode then
    node.pos = 2
    nodes = {i(1), node}
  else
    node.pos = 1
    nodes = {node}
  end
  return sn(pos, nodes, {
    callbacks = {
      -- node has pos 1 inside the snippetNode.
      [1] = {
        [events.enter] = function(nd)
          -- node_pos: {line, column}
          local node_pos = nd.mark:pos_begin()
          -- reuse luasnips namespace, column doesn't matter, just 0 it.
          nd.virt_text_id = vim.api.nvim_buf_set_extmark(0, ls.session.ns_id,
                                                         node_pos[1], 0, {
            virt_text = {{text, "GruvboxOrange"}}
          })
        end,
        [events.leave] = function(nd)
          vim.api.nvim_buf_del_extmark(0, ls.session.ns_id, nd.virt_text_id)
        end
      }
    }
  })
end

local function nodes_with_virtual_text(nodes, opts)
  if opts == nil then
    opts = {}
  end
  local new_nodes = {}
  for pos, node in ipairs(nodes) do
    if opts.texts[pos] ~= nil then
      node = node_with_virtual_text(pos, node, opts.texts[pos])
    end
    table.insert(new_nodes, node)
  end
  return new_nodes
end

local function choice_text_node(pos, choices, opts)
  choices = nodes_with_virtual_text(choices, opts)
  return c(pos, choices, opts)
end

local ct = choice_text_node

local docstring = function(args)
  local arg_list = args[1][1]
  -- Remove any occurances of self from list
  arg_list = arg_list:gsub("self,", "")
  -- Remove -> from return type hint
  local return_type = args[2][1]:gsub(" %-> ", "")

  -- Create Full Description Choice
  local full_desc = {}
  table.insert(full_desc, t("\t" .. [[""" ]]))
  table.insert(full_desc, r(1, "description", i(nil)))
  table.insert(full_desc, t({"", "", "\tParameters", "\t----------", ""}))
  local insert_index = 2
  -- Loop through function arguments
  for str in string.gmatch(arg_list, "([^" .. "," .. "]+)") do
    -- Remove all spaces from argument
    str = str:gsub("%s+", "")
    -- If argument has a type hint, just use that
    if not str:find(":") then
      table.insert(full_desc, t("\t" .. str .. ": "))
      table.insert(full_desc, i(insert_index, "Type"))
      insert_index = insert_index + 1
    else
      -- Replace : with ": " for better formatting
      str = str:gsub(":", ": ")
      table.insert(full_desc, t("\t" .. str))
    end
    table.insert(full_desc, t({"", "\t\t"}))
    table.insert(full_desc, i(insert_index, "Argument Description"))
    insert_index = insert_index + 1
    table.insert(full_desc, t({"", ""}))
  end
  table.insert(full_desc, t({"", "\tReturns", "\t-------", ""}))
  -- If return type is provided, insert it; otherwise, ask
  if return_type ~= "" then
    table.insert(full_desc, t({"\t" .. return_type .. ":", "\t\t"}))
  else
    table.insert(full_desc, t("\t"))
  end
  table.insert(full_desc, i(insert_index))
  insert_index = insert_index + 1
  table.insert(full_desc, t({"", "\t" .. [["""]]}))
  local full_desc_node = sn(nil, full_desc)

  -- Create Short Description Choice
  local short_desc = {}
  table.insert(short_desc, t("\t" .. [[""" ]]))
  table.insert(short_desc, r(1, "description", i(nil)))
  table.insert(short_desc, t([[ """]]))
  local short_desc_node = sn(nil, short_desc)

  return sn(nil, ct(1, {full_desc_node, short_desc_node, t("")}, {
    texts = {"(full docstring)", "(single line docstring)", "(no docstring)"}
  }))
end

local func_body = function(args)
  local docstring = args[1][1]
  local nodes = {}
  if docstring == "" then
    table.insert(nodes, t("\t"))
  else
    table.insert(nodes, t({"", "\t"}))
  end
  table.insert(nodes, r(1, "function_definition", i(nil, "pass")))
  return sn(nil, nodes)
end

local init_body = function(args)
  local arg_list = args[1][1]
  local docstring = args[2][1]
  -- Remove any occurances of self from list
  arg_list = arg_list:gsub("self,", "")

  local nodes = {}
  local insert_index = 1
  for str in string.gmatch(arg_list, "([^" .. "," .. "]+)") do
    -- Remove all spaces from argument
    str = str:gsub("%s+", "")
    -- Remove type hints
    str = str:gsub("(.*):.*$", "%1")
    if docstring == "" and insert_index == 1 then
      table.insert(nodes, t("self."))
    else
      table.insert(nodes, t({"", "\t\tself."}))
    end
    table.insert(nodes, i(insert_index, str))
    insert_index = insert_index + 1
    table.insert(nodes, t(" = " .. str))
  end
  return sn(nil, nodes)
end

local auto = {}

local standard = {}
-- Function/method definition
table.insert(standard, s("d", fmt([[
          def {func}({args}){ret}:
          {doc}{body}
        ]], {
  func = i(1, "my_function"),
  args = ct(2, {
    r(1, "arguments", i(nil, "arg1")),
    sn(nil, {t("self, "), r(1, "arguments", i(nil, "arg1"))})
  }, {texts = {"(function)", "(method)"}}),
  ret = ct(3, {t(""), sn(nil, {t(" -> "), i(1)})},
           {texts = {"(no return type)", "(return type)"}}),
  doc = d(4, docstring, {2, 3}),
  body = d(5, func_body, {4})
})))

-- Class definition
table.insert(standard, s("cl", fmt([[
class {class}({object}):
    {doc}def __init__(self, {args}):
        {init_doc}{body}
]], {
  class = i(1, "MyClass"),
  object = i(2, "object"),
  doc = ct(3, {sn(nil, {t([[""" ]]), i(1), t({[[ """]], "\t"})}), t("")},
           {texts = {"(Docstring)", "(No Docstring)"}}),
  args = i(4, "arg1"),
  init_doc = ct(5, {sn(nil, {t([[""" ]]), i(1), t([[ """]])}), t("")},
                {texts = {"(Docstring)", "(No Docstring)"}}),
  body = d(6, init_body, {4, 5})
})))

-- Environment
table.insert(standard, s("env", t {"#!/usr/bin/env python", ""}))

-- if __name__ == "__main__"
table.insert(standard, s("ifmain", fmt([[
if __name__ == "__main__":
    {}
]], i(1, "pass"))))

-- With statement
table.insert(standard, s("with", fmt([[
with {} as {}:
    {}
]], {i(1, "expr"), i(2, "var"), i(3, "pass")})))

-- For loop
table.insert(standard, s("for", fmt([[
for {} in {}:
    {}
]], {i(1, "item"), i(2, "iterable"), i(3, "pass")})))

-- from x import y
table.insert(standard, s("from", fmt([[
from {} import {}
]], {i(1, "module"), i(2, "stuff")})))

-- Import
table.insert(standard, s("imp", fmt([[import {}]], i(1, "module"))))

-- If statements
table.insert(standard, s("if", fmt([[
if {}:
    {}
]], {i(1, "condition"), i(2, "pass")})))

table.insert(standard, s("ife", fmt([[
if {}:
    {}
else:
    {}
]], {i(1, "condition"), i(2, "pass"), i(3, "pass")})))

table.insert(standard, s("ifee", fmt([[
if {}:
    {}
elif {}:
    {}
else:
    {}
]], {i(1, "condition"), i(2, "pass"), i(3, "condition"), i(4, "pass"), i(5, "pass")})))

-- Try Except
table.insert(standard, s("try", fmt([[
try:
    {}
except {}:
    {}
]], {i(1, "pass"), i(2, "Exception"), i(3, "pass")}))) -- TODO: Make Exception handling a choice node for exception as e

-- List comprehension
table.insert(standard, s("lc", fmt([[
[{} for {} in {}]{}
]], {i(1), i(2, "item"), i(3, "iterable"), i(0)})))

-- Common imports
table.insert(standard, s("pyplot", t("import matplotlib.pyplot as plt")))
table.insert(standard, s("numpy", t("import numpy as np")))
table.insert(standard, s("xarray", t("import xarray as xr")))
table.insert(standard, s("pandas", t("import pandas as pd")))

return standard
