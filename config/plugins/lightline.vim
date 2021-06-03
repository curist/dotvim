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
      \   },
      \   'tab': {
      \      'active': [ 'filename' ],
      \      'inactive': [ 'filename' ],
      \    },
      \   'active': {
      \     'left': [
      \               [ 'mode' ],
      \               [ 'fileencoding' ],
      \               [ 'filename' ],
      \             ],
      \     'right': [
      \                ['lineinfo' ], [ 'githead' ], ['filetype'],
      \                ['fileformat'], [ 'lsp' ],
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
      \     'lsp': 'LspStatus',
      \   },
      \ }

function! LightlineMode()
  return lightline#mode()
endfunction

function! LightlineFilename()
  let filename = expand('%:~:.')
  let mod = Mod()
  return mod . filename
endfunction

function! LightlineInactiveFilename()
  if &buftype == 'terminal'
    return 'TERM'
  endif
  let filename = expand('%:~:.')
  if filename == ''
    return 'NONAME'
  endif
  let mod = Mod()
  return mod . filename
endfunction

function! LightLineGitHead()
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
  return &filetype
endfunction

function! LspStatus() abort
  if luaeval('next(vim.lsp.buf_get_clients())')
    if luaeval('vim.lsp.buf.server_ready()')
      return '[Ξ]'
    end
    return 'Ξ'
  end
  return ''
endfunction
