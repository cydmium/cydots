setlocal expandtab
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal indentexpr=
augroup python_files
  autocmd!
  autocmd BufWritePre * %s/\s\+$//e
augroup end
