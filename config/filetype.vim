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

  " git
  autocmd FileType git*,diff set bufhidden=delete

  " fossil
  autocmd BufRead ci-comment-*.txt set ft=gitcommit

  " hcl
  autocmd BufNew,BufEnter *.nomad set ft=hcl

  " zig
  autocmd FileType zig setlocal ai sw=4 sts=4 et commentstring=//\ %s
  autocmd FileType zig nn <silent><buffer> <leader>tf <cmd>lua require('dot.ts').run_zig_test()<cr>
  autocmd FileType zig nn <silent><buffer> <leader>tn <cmd>lua require('dot.ts').run_nearest_zig_test()<cr>

augroup END


augroup MyFileTypeMappings
  " run settings
  autocmd!
  autocmd FileType javascript nn <buffer> <leader>r :w<cr>:!node %<cr>
  autocmd FileType typescript nn <buffer> <leader>r :w<cr>:!deno run %<cr>
  autocmd FileType lua nn <buffer> <leader>r :w<cr>:!lua %<cr>
  autocmd FileType lx nn <buffer> <leader>r :w<cr>:!lx run --debug %<cr>
augroup END
