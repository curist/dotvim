augroup MyFileTypeSettings
  autocmd!
  " general settings
  autocmd FileType javascript,yaml,html,markdown,css setlocal ai sw=2 sts=2 et
  autocmd FileType typescript,typescript.tsx,vim,lua setlocal ai sw=2 sts=2 et

  " markdown
  autocmd FileType markdown setlocal suffixesadd=.md

  " golang
  autocmd FileType go setlocal noexpandtab

  " cloudformation
  autocmd BufRead *cloudformation-template.json set ft=json.cloudformation
  autocmd BufRead *cloudformation-template.yaml set ft=yaml.cloudformation

  " graphql
  autocmd BufRead *.graphql set ft=graphql

  " git
  let $GIT_EDITOR = 'nvr -cc split --remote-wait'
  autocmd FileType git*,diff set bufhidden=delete
augroup END
