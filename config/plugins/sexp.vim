let g:sexp_filetypes = ''
function! s:vim_sexp_mappings()
  nmap <silent><buffer> <C-k>           <Plug>(sexp_swap_list_backward)
  xmap <silent><buffer> <C-k>           <Plug>(sexp_swap_list_backward)
  nmap <silent><buffer> <C-j>           <Plug>(sexp_swap_list_forward)
  xmap <silent><buffer> <C-j>           <Plug>(sexp_swap_list_forward)
  nmap <silent><buffer> <C-h>           <Plug>(sexp_swap_element_backward)
  xmap <silent><buffer> <C-h>           <Plug>(sexp_swap_element_backward)
  nmap <silent><buffer> <C-l>           <Plug>(sexp_swap_element_forward)
  xmap <silent><buffer> <C-l>           <Plug>(sexp_swap_element_forward)
  nmap <silent><buffer> <M-S-j>         <Plug>(sexp_emit_head_element)
  xmap <silent><buffer> <M-S-j>         <Plug>(sexp_emit_head_element)
  nmap <silent><buffer> <M-S-k>         <Plug>(sexp_emit_tail_element)
  xmap <silent><buffer> <M-S-k>         <Plug>(sexp_emit_tail_element)
  nmap <silent><buffer> <M-S-h>         <Plug>(sexp_capture_prev_element)
  xmap <silent><buffer> <M-S-h>         <Plug>(sexp_capture_prev_element)
  nmap <silent><buffer> <M-S-l>         <Plug>(sexp_capture_next_element)
  xmap <silent><buffer> <M-S-l>         <Plug>(sexp_capture_next_element)

  nmap <silent><buffer> (               <Plug>(sexp_move_to_prev_bracket)
  nmap <silent><buffer> )               <Plug>(sexp_move_to_next_bracket)
  nmap <silent><buffer> <M-b>           <Plug>(sexp_move_to_prev_element_head)
  nmap <silent><buffer> <M-w>           <Plug>(sexp_move_to_next_element_head)
  nmap <silent><buffer> <M-e>           <Plug>(sexp_move_to_next_element_tail)
  nmap <silent><buffer> [[              <Plug>(sexp_move_to_prev_top_element)
  nmap <silent><buffer> ]]              <Plug>(sexp_move_to_next_top_element)
endfunction

augroup VIM_SEXP_MAPPING
  autocmd!
  autocmd FileType clojure,scheme,lisp call s:vim_sexp_mappings()
augroup END