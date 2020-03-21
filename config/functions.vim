" remove trailing spaces
function! KillTrailingSpaces()
  let l:save_cursor = getpos('.')
  :%s/\s\+$//e
  :call cursor(l:save_cursor[1], l:save_cursor[2], l:save_cursor[3])
endfunction

command! -nargs=* T setlocal splitbelow | Term <args>
command! -nargs=* VT setlocal splitright | VTerm <args>

