let g:lightline = {
      \   'colorscheme': 'one',
      \   'mode_map': {
      \     'n' : 'N',
      \     'i' : 'I',
      \     'R' : 'R',
      \     'v' : 'V',
      \     'V' : 'VL',
      \     "\<C-v>": 'VB',
      \     'c' : 'C',
      \     's' : 'S',
      \     'S' : 'SL',
      \     "\<C-s>": 'SB',
      \     't': 'T',
      \     },
      \   'active': {
      \     'left': [ [ 'mode', 'paste' ],
      \               [ 'fileencoding' ],
      \               [ 'filename' ],
      \             ],
      \     'right': [ ['lineinfo' ], [ 'githead' ], ['filetype'],
      \                ['fileformat'],
      \              ],
      \   },
      \   'inactive': {
      \     'left': [ ['inactivefilename'] ],
      \     'right': [],
      \   },
      \   'component': {
      \     'fileencoding': "%{&fenc=='utf-8'?'':&fenc}",
      \     'fileformat': "%{&ff=='unix'?'':&ff}",
      \     'filetype': '%{&ft}',
      \     'lineinfo': '%3l:%-2c',
      \     'inactivefilename': "%{&readonly?'':expand('%:~:.')}"
      \   },
      \   'component_function': {
      \     'mode': 'LightlineMode',
      \     'filename': 'LightlineFilename',
      \     'githead': 'FugitiveHead',
      \   },
      \ }

function! LightlineMode()
  if &filetype ==# 'list' && exists('b:list_status')
    let l:mode = get(b:list_status, 'mode')
    return l:mode ==# 'NORMAL' ? 'N' : 'I'
  endif
  return lightline#mode()
endfunction

function! LightlineFilename()
  let filename = expand('%:~:.')
  let mod = Mod()
  return mod . filename
endfunction

function! FugitiveHead()
  return fugitive#Head(6)
endfunction

function! Mod()
  if &readonly
    return '- '
  elseif &modified
    return '+ '
  endif
  return ''
endfunction

augroup filetype_nerdtree
  au!
  au FileType nerdtree call s:disable_lightline_on_nerdtree()
  au WinEnter,BufWinEnter,TabEnter * call s:disable_lightline_on_nerdtree()
augroup END

fu s:disable_lightline_on_nerdtree() abort
  let nerdtree_winnr = index(map(range(1, winnr('$')), {_,v -> getbufvar(winbufnr(v), '&ft')}), 'nerdtree') + 1
  call timer_start(0, {-> nerdtree_winnr && setwinvar(nerdtree_winnr, '&stl', '%#Normal#')})
endfu
