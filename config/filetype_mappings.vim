let mapleader = ","
augroup MyFileTypeMappings
  " run settings
  autocmd FileType c nn <buffer> <leader>r :w<cr>:!gcc % -o ~/bin/%:t:r<cr>:!~/bin/%:t:r<cr>
  autocmd FileType cpp nn <buffer> <leader>r :w<cr>:!g++ % -o ~/bin/%:t:r<cr>:!~/bin/%:t:r<cr>
  autocmd FileType cs nn <buffer> <leader>r :w<cr>:!mcs %<cr>:!mono %:r.exe<cr>
  autocmd FileType java nn <buffer> <leader>r :w<cr>:!javac %<cr>:!java %:t:r<cr>
  autocmd FileType python nn <buffer> <leader>r :w<cr>:!python %<cr>
  autocmd FileType perl nn <buffer> <leader>r :w<cr>:!perl %<cr>
  autocmd FileType lua nn <buffer> <leader>r :w<cr>:make<cr>
  autocmd FileType javascript nn <buffer> <leader>r :w<cr>:!node %<cr>
  autocmd FileType coffee nn <buffer> <leader>r :w<cr>:!coffee %<cr>
  autocmd FileType coffee vn <buffer> <leader>r :w !coffee -s<cr>
  autocmd FileType coffee nn <buffer> <leader>c :w<cr>:!coffee -p %<cr>
  autocmd FileType coffee vn <buffer> <leader>c :w !coffee -psb<cr>
  autocmd FileType ruby nn <buffer> <leader>r :w<cr>:!ruby %<cr>
  autocmd FileType markdown
        \ nn <buffer> <leader>r
        \ :w<cr>:!markdown % > /tmp/%:t:r.html && firefox -new-tab /tmp/%:t:r.html<cr>
augroup END
