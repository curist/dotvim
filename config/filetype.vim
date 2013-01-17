augroup MyFileTypeSettings
  " general settings
  autocmd FileType javascript,ruby,eruby,yaml,vim,coffee,html,markdown,vimwiki,jade setlocal ai sw=2 sts=2 et
  autocmd FileType python setlocal ai sw=4 sts=4 et

  " markdown and vimwiki wrap lines
  autocmd FileType markdown,vimwiki setlocal wrap
  autocmd FileType vimwiki setlocal nohidden
  autocmd FileType vimwiki setlocal filetype=markdown.vimwiki

  " exclusive use cindent for c and cpp
  autocmd FileType c,h,cpp,hpp setlocal cindent

  " java complete setting
  autocmd FileType java setlocal omnifunc=javacomplete#Complete
  autocmd FileType java setlocal completefunc=javacomplete#Complete

  " c/c++ compiletion settings
  autocmd FileType c setlocal mp=gcc\ -g\ -Wall\ %\ -o\ ~/bin/%:t:r
  autocmd FileType cpp setlocal mp=g++\ -g\ -Wall\ %\ -o\ ~/bin/%:t:r

  " lua quickfix settings
  autocmd FileType lua setlocal mp=lua\ %
  autocmd BufRead *.lua setlocal efm=lua:\ %f:%l:%m

  " tintin++ setting
  autocmd BufEnter,BufNew *.tt setlocal syntax=tt

  " javascript files run JSHint upon save
  autocmd FileType javascript autocmd BufWritePost <buffer> exe ":JSHint"

  " sqlpython buffer skips parsing by wrap the sql in REMARK BEGIN and REMARK END
  autocmd BufNewFile,BufRead afiedt.buf setfiletype sql
  autocmd BufWritePre afiedt.buf call SqlRemarkWrapping()

  " remap sql omni-completion
  let g:ftplugin_sql_omni_key = '<c-j>'

  " xml formatting
  autocmd FileType xml setlocal equalprg=xmllint\ --format\ --recover\ --encode\ utf-8\ -

  "" killing trailing spaces when saving file
  autocmd FileType c,cpp,java,php,python,perl,ruby,javascript,vim
        \ autocmd BufWritePre <buffer> :call KillTrailingSpaces()
augroup END

