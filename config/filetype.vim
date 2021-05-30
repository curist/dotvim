augroup MyFileTypeSettings
  autocmd!
  " general settings
  autocmd FileType javascript,yaml,html,markdown,css setlocal ai sw=2 sts=2 et
  autocmd FileType typescript,typescript.tsx,vim,lua setlocal ai sw=2 sts=2 et

  " markdown
  autocmd FileType markdown setlocal suffixesadd=.md

  " golang
  autocmd FileType go setlocal noexpandtab

  " vtl
  au BufNewFile,BufRead *.vtl set ft=velocity

  " cloudformation
  autocmd BufRead *cloudformation-template.* set ft+=.cloudformation
augroup END
