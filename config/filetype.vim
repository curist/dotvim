augroup MyFileTypeSettings
  autocmd!
  " general settings
  autocmd FileType javascript,yaml,html,markdown,css setlocal ai sw=2 sts=2 et
  autocmd FileType typescript,typescript.tsx,vim,vimwiki setlocal ai sw=2 sts=2 et
  autocmd FileType lua setlocal ai sw=2 sts=2 et
  autocmd FileType python setlocal ai sw=4 sts=4 et

  " markdown and vimwiki settings
  autocmd FileType markdown,vimwiki setlocal wrap
  autocmd FileType vimwiki setlocal nohidden
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


  " golang
  autocmd FileType go setlocal noexpandtab
  autocmd FileType go setlocal commentstring=//%s

  " clojure
  autocmd FileType clojure setlocal commentstring=;;%s

  " vue
  autocmd FileType vue,javascript setlocal includeexpr=substitute(v:fname,'^\\~','src','')
  let g:vim_vue_plugin_use_sass = 1

  " vtl
  au BufNewFile,BufRead *.vtl set ft=velocity
augroup END
