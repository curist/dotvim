augroup MyFileTypeSettings
  autocmd!
  " general settings
  autocmd FileType javascript,yaml,html,markdown,css setlocal ai sw=2 sts=2 et
  autocmd FileType typescript,typescript.tsx,vim,lua setlocal ai sw=2 sts=2 et

  " markdown
  autocmd FileType markdown setlocal suffixesadd=.md
  autocmd FileType markdown setlocal wrap

  " golang
  autocmd FileType go setlocal noexpandtab sw=0 tabstop=4 listchars=tab:\ \ 

  " cloudformation
  autocmd BufRead *cloudformation-template.json set ft=json.cloudformation
  autocmd BufRead *cloudformation-template.yaml set ft=yaml.cloudformation

  " graphql
  autocmd BufRead *.graphql set ft=graphql

  " git
  let $GIT_EDITOR = 'nvr -cc split --remote-wait'
  autocmd FileType git*,diff set bufhidden=delete

  " fossil
  let $VISUAL = 'nvr -cc split --remote-wait'
  autocmd BufRead ci-comment-*.txt set ft=gitcommit
augroup END
