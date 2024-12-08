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

  " zig
  autocmd FileType zig setlocal ai sw=4 sts=4 et commentstring=//\ %s

  " noice
  autocmd FileType noice setlocal wrap

  " help
  autocmd FileType help nn <buffer> gd <c-]>

lua << EOF
vim.filetype.add({
  extension = {
    nomad = "hcl",
    lx = "lx",
  },
  pattern = {
    ["ci-comment-*.txt"] = "gitcommit",
  }
})
EOF

augroup END


augroup MyFileTypeMappings
  " run settings
  autocmd!
  autocmd FileType javascript nn <buffer> <localleader>r :w<cr>:!deno run --allow-all %<cr>
  autocmd FileType typescript nn <buffer> <localleader>r :w<cr>:!deno run --allow-all %<cr>
  autocmd FileType lua nn <buffer> <localleader>r :w<cr>:!lua %<cr>
  autocmd FileType lx nn <buffer> <localleader>r :w<cr>:!lx run %<cr>
  autocmd FileType fennel nn <buffer> <localleader>r :w<cr>:!fennel %<cr>
augroup END
