let g:clap_provider_grep_delay = 50
let g:clap_provider_grep_opts = "-H --no-heading --vimgrep --smart-case --hidden -g !.git/"
let g:clap_layout = { 'relative': 'editor' }
let g:clap_insert_mode_only = 1

nn <silent> <leader>s :Clap grep ++query=<cword><cr>
vn <silent> <leader>s :Clap grep ++query=@visual<cr>
nn <silent> <leader>S :Clap grep<cr>
nn <silent> <leader>f :Clap files<cr>
nn <silent> <leader>b :Clap buffers<cr>
nn <silent> <leader>m :Clap history<cr>
nn <silent> <leader>: :Clap command_history<cr>
nn <silent> <leader>/ :Clap search_history<cr>


augroup clap_
  autocmd!
  au User ClapOnExit call lightline#update()
augroup END


