let g:vaffle_show_hidden_files = 1
let g:vaffle_force_delete = 1

nnoremap <silent> <leader>v :Vaffle<cr>

function! SmartVaffle()
  if @% == ""
    Vaffle %:p:h
  else
    Vaffle %
  endif
endfun
nnoremap <silent> <leader>V :call SmartVaffle()<cr>

function! VaffleRenderCustomIcon(item)
  return WebDevIconsGetFileTypeSymbol(a:item.basename, a:item.is_dir)
endfunction
let g:vaffle_render_custom_icon = 'VaffleRenderCustomIcon'
