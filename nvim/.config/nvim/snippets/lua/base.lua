local req_snip = function(import_name)
  local parts = vim.split(import_name[1][1], ".", true)
  return parts[#parts] or ""
end

return {
  parse("lf", "local $1 = function($2)\n  $0\nend"),
  parse("func", "$1 = function($2)\n  $0\nend"),
  s("req", fmt([[local {} = require "{}"]], {f(req_snip, {1}), i(1)}))
}
