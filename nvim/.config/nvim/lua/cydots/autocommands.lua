create_autocmd({ "BufWritePre" }, {
  pattern = { "*.c", "*.cpp", "*.lua", "*.md", "*.py", "*.rs", "*.sh" },
  command = [[%s/\s\+$//e]],
  group = create_augroup("remote_whitespace", { clear = true }),
})
