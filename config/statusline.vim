augroup StatusLine
  autocmd!

  let g:currentmode={
      \ 'n'      : 'N',
      \ 'no'     : 'N',
      \ 'v'      : 'V',
      \ 'V'      : 'V',
      \ ''     : 'V',
      \ 's'      : 'Select',
      \ 'S'      : 'S·Line',
      \ ''     : 'S·Block',
      \ 'i'      : 'I',
      \ 'R'      : 'R',
      \ 'Rv'     : 'V',
      \ 'c'      : 'C',
      \ 'cv'     : 'C',
      \ 'ce'     : 'C',
      \ 'r'      : 'Prompt',
      \ 'rm'     : 'More',
      \ 'r?'     : 'Confirm',
      \ '!'      : 'T',
      \ 't'      : 'T'
      \}

  function! ModeText(s)
    let m = mode()
    let t = g:currentmode[m]
    if t == a:s
      return '  '.a:s.' '
    endif
    if strlen(t) > 1 && a:s == 'other'
      return '  '.t.' '
    endif
    return ''
  endfunction

  function! GitInfo()
    let git = fugitive#head(6)
    return git == '' ? '' : ' '.git.' '
  endfunction

  function! Mod()
    if &readonly
      return '  - '
    elseif &modified
      return '  + '
    endif
    return ''
  endfunction

  set laststatus=2                            " status bar setting
  set statusline=
  set statusline+=%#DiffAdd#%{ModeText('N')}      " normal
  set statusline+=%#DiffChange#%{ModeText('I')}   " insert
  set statusline+=%#DiffAdded#%{ModeText('R')}
  set statusline+=%#Search#%{ModeText('C')}
  set statusline+=%#DiffDelete#%{ModeText('T')}
  set statusline+=%#Cursor#%{ModeText('V')}
  set statusline+=%#MatchParen#%{ModeText('other')}
  set statusline+=%#Visual#                   " colour
  set statusline+=%{&paste?'\ \ PASTE\ ':''}
  set statusline+=%#CursorIM#                 " colour
  set statusline+=%{Mod()}                    " readonly/modified flag
  set statusline+=%#Cursor#                   " colour
  set statusline+=%#CursorLine#               " colour
  set statusline+=\ %{expand('%:~:.')}\       " relative file path
  set statusline+=%#Comment#%{&fileencoding=='utf-8'?'':'\ '.&fileencoding.'\ '}
  set statusline+=%#CursorLine#               " colour
  set statusline+=%=                          " right align
  set statusline+=%{&fileformat}\             " fileformat
  set statusline+=%#Comment#                  " colour
  set statusline+=\ %Y\                       " file type
  set statusline+=%#CursorIM#%{GitInfo()}     " git branch
  set statusline+=%#DiffChange#               " colour
  set statusline+=\ %3l:%-2c\                 " line + column
  set statusline+=%#Cursor#                   " colour
  set statusline+=\ %3p%%\                    " percentage

augroup END
