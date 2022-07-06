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

local auto = {}

local standard = {}
table.insert(standard, s("d", fmt([[
          def {func}({args}){ret}:
          {doc}{body}
        ]], {
  func = i(1, "function_name"),
  args = ct(2, {
    r(1, "arguments", i(nil, "arg1")),
    sn(nil, {t("self, "), r(1, "arguments", i(nil, "arg1"))})
  }, {texts = {"(function)", "(method)"}}),
  ret = c(3, {t(""), sn(nil, {t(" -> "), i(1)})}),
  doc = d(4, docstring, {2, 3}),
  body = i(0)
})))
return standard
