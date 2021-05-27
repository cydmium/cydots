setlocal spell
inoremap <c-l> <c-g>U<esc>[s1z=``<c-g>a
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal expandtab
setlocal conceallevel=2
augroup tex_files
    autocmd!
    autocmd InsertLeave,TextChanged *.tex update
    autocmd VimLeave *.tex !cleanLatex %
augroup end
