let g:lightline = {
      \   'colorscheme': 'jellybeans',
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
      \     'lineinfo': '%3l:%-2c',
      \   },
      \   'component_function': {
      \     'mode': 'LightlineMode',
      \     'filename': 'LightlineFilename',
      \     'inactivefilename': 'LightlineInactiveFilename',
      \     'githead': 'LightLineGitHead',
      \     'filetype': 'FileType',
      \   },
      \ }

let g:pluginFileTypes = {
      \ 'nerdtree': 1,
      \ }

function! LightlineMode()
  if has_key(g:pluginFileTypes, &filetype)
    return ''
  endif
  return lightline#mode()
endfunction

function! LightlineFilename()
  if has_key(g:pluginFileTypes, &filetype)
    return toupper(&filetype)
  endif
  let filename = expand('%:~:.')
  let mod = Mod()
  return mod . filename
endfunction

function! LightlineInactiveFilename()
  if has_key(g:pluginFileTypes, &filetype)
    return toupper(&filetype)
  endif
  if &buftype == 'terminal'
    return 'TERM'
  endif
  let filename = expand('%:~:.')
  if filename == ''
    return 'NOFILE'
  endif
  return filename
endfunction

function! LightLineGitHead()
  if has_key(g:pluginFileTypes, &filetype)
    return ''
  endif
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

function! FileType()
  if has_key(g:pluginFileTypes, &filetype)
    return ''
  endif
  return &filetype
endfunction
