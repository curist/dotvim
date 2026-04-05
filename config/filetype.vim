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
    lx = 'lx',
    bb = 'clojure',
    tw = 'twinkle',
  },
})
EOF

augroup END

augroup fennel_format_map
  autocmd!
  autocmd FileType fennel nnoremap <buffer> = gq
  autocmd FileType fennel xnoremap <buffer> = gq
  autocmd FileType fennel nnoremap <buffer> == gqq
augroup END

augroup MyFileTypeMappings
  " run settings
  autocmd!
  autocmd FileType lua nn <buffer> <localleader>r :w<cr>:!nlua %<cr>
  autocmd FileType lx nn <buffer> <localleader>r :w<cr>:!lx run %<cr>
  autocmd FileType fennel nn <buffer> <localleader>r :w<cr>:!fennel %<cr>
  autocmd FileType python nn <buffer> <localleader>r :w<cr>:!python3 %<cr>
augroup END
