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

  let g:git_head = ''
  function! UpdateGitHead()
    let git = fugitive#Head(6)
    if git == ''
      let g:git_head = ''
    else
      let g:git_head = ' '.git.' '
    endif
  endfunction
  autocmd CursorHold * call UpdateGitHead()

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
  set statusline+=%#Comment#%{&fenc=='utf-8'?'':'\ '.&fenc.'\ '} " file encoding
  set statusline+=%#CursorLine#               " colour
  set statusline+=%=                          " right align
  set statusline+=%#Comment#%{&ff=='unix'?'':'\ '.&ff.'\ '}
  set statusline+=%#CursorLine#               " colour
  set statusline+=\ %Y\                       " file type
  set statusline+=%#DiffChange#               " colour
  set statusline+=%{g:git_head}               " git branch
  set statusline+=%#Cursor#                   " colour
  set statusline+=\ %P\                       " percentage

augroup END
