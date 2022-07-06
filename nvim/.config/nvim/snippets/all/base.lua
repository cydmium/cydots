return {
  s("todo", {
    c(1, {
      fmt("TODO: {}", r(1, "text", i(nil))),
      fmt("FIXME: {}", r(1, "text", i(nil))),
      fmt("TODONT: {}", r(1, "text", i(nil)))
    })
  }),
  s("date", f(function()
    return os.date "%D"
  end))
}
