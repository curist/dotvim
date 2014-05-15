augroup MyFileTypeSettings
  autocmd!
  " general settings
  autocmd FileType javascript,ruby,eruby,yaml,vim,coffee,html,markdown,vimwiki,jade setlocal ai sw=2 sts=2 et
  autocmd FileType python setlocal ai sw=4 sts=4 et

  " markdown and vimwiki wrap lines
  autocmd FileType markdown,vimwiki setlocal wrap
  autocmd FileType vimwiki setlocal nohidden
  autocmd FileType vimwiki setlocal filetype=markdown.vimwiki
  let g:markdown_fenced_languages = [
        \ 'coffee',
        \ 'css',
        \ 'erb=eruby',
        \ 'javascript',
        \ 'js=javascript',
        \ 'json=javascript',
        \ 'ruby',
        \ 'sass',
        \ 'xml',
        \ 'python',
        \ 'go']

  " exclusive use cindent for c and cpp
  autocmd FileType c,objc,h,cpp,hpp setlocal cindent

  " java complete setting
  autocmd FileType java setlocal omnifunc=javacomplete#Complete
  autocmd FileType java setlocal completefunc=javacomplete#Complete

  " c/c++ compiletion settings
  autocmd FileType c setlocal mp=gcc\ -g\ -Wall\ %\ -o\ ~/bin/%:t:r
  autocmd FileType cpp setlocal mp=g++\ -g\ -Wall\ %\ -o\ ~/bin/%:t:r

  " objc
  autocmd BufRead,BufNewFile *.m setlocal filetype=objc

  " lua quickfix settings
  autocmd FileType lua setlocal mp=lua\ %
  autocmd BufRead *.lua setlocal efm=lua:\ %f:%l:%m

  " tintin++ setting
  autocmd BufRead,BufNewFile *.tt setlocal syntax=tt

  " javascript code completion
  autocmd FileType javascript setlocal completefunc=tern#Complete

  " sqlpython buffer skips parsing by wrap the sql in REMARK BEGIN and REMARK END
  autocmd BufNewFile,BufRead afiedt.buf setfiletype sql
  autocmd BufWritePre afiedt.buf call SqlRemarkWrapping()

  " remap sql omni-completion
  let g:ftplugin_sql_omni_key = '<c-j>'

  " xml formatting
  autocmd FileType xml setlocal equalprg=xmllint\ --format\ --recover\ --encode\ utf-8\ -

  "" killing trailing spaces when saving file
  autocmd FileType c,cpp,java,php,python,perl,ruby,javascript,vim
        \ autocmd! BufWritePre <buffer> :call KillTrailingSpaces()

  " golang
  autocmd FileType go setlocal noexpandtab
  autocmd FileType go autocmd! BufWritePre <buffer> :call Fmt_()
  autocmd FileType go setlocal commentstring=//%s
  " let g:golang_goos = 'linux'
  " let g:golang_goarch = 'amd64'
  let g:gocode_gofmt_tabwidth=""
augroup END
