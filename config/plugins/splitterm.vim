command! -bang -nargs=* T setlocal splitbelow | Term<bang> <args>
command! -bang -nargs=* VT setlocal splitright | VTerm<bang> <args>

nn <silent> <m-t> :TT<cr>
nn <silent> <m-T> :TT!<cr>
