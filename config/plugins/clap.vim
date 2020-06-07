let g:clap_provider_grep_delay = 50
let g:clap_provider_grep_opts = "-H --no-heading --vimgrep --smart-case --hidden -g !.git/"
let g:clap_layout = { 'relative': 'editor' }

nn <silent> <leader>s :Clap grep ++query=<cword><cr>
nn <silent> <leader>S :Clap grep<cr>
nn <silent> <leader>f :Clap files<cr>
nn <silent> <leader>b :Clap buffers<cr>
nn <silent> <leader>m :Clap history<cr>
nn <silent> <leader>: :Clap command_history<cr>
nn <silent> <leader>/ :Clap search_history<cr>


augroup clap_
  autocmd!
  au User ClapOnExit call lightline#update()
  au FileType clap_input call ClapInput()
augroup END

function! ClapInput()
  nn <buffer><silent> <esc> <esc>:call clap#handler#exit()<cr>
  ino <buffer><silent> <esc> <esc>:call clap#handler#exit()<cr>
endfunction

