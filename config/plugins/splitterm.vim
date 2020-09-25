command! -nargs=* T setlocal splitbelow | Term <args>
command! -nargs=* VT setlocal splitright | VTerm <args>

nn <silent> <m-T> :TT<cr>
