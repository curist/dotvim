let g:lightline = {
      \   'colorscheme': 'edge',
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
      \     'inactivefilename': "%{expand('%:~:.')}",
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
