augroup MyFileTypeSettings
  autocmd!
  " general settings
  autocmd FileType javascript,yaml,html,markdown setlocal ai sw=2 sts=2 et
  autocmd FileType typescript,typescript.tsx,reason,vim,vimwiki setlocal ai sw=2 sts=2 et
  autocmd FileType python setlocal ai sw=4 sts=4 et

  autocmd FileType typescript setlocal signcolumn=yes

  " markdown and vimwiki settings
  autocmd FileType markdown,vimwiki setlocal wrap
  autocmd FileType vimwiki setlocal nohidden
  autocmd FileType vimwiki setlocal filetype=markdown.vimwiki
  let g:markdown_fenced_languages = [
        \ 'css',
        \ 'clojure',
        \ 'clj=clojure',
        \ 'erb=eruby',
        \ 'javascript',
        \ 'js=javascript',
        \ 'ts=typescript',
        \ 'json=javascript',
        \ 'ruby',
        \ 'sass',
        \ 'html',
        \ 'xml',
        \ 'python',
        \ 'go' ]


  "" killing trailing spaces when saving file
  autocmd FileType c,cpp,janet,python,ruby,javascript,vim,typescript
        \ autocmd! BufWritePre <buffer> :call KillTrailingSpaces()

  " golang
  autocmd FileType go setlocal noexpandtab
  autocmd FileType go setlocal commentstring=//%s

  " clojure
  autocmd FileType clojure setlocal commentstring=;;%s

  autocmd FileType janet hi! def link JanetSymbol Normal
  autocmd FileType janet hi! def link JanetSpecialForm Identifier
augroup END
