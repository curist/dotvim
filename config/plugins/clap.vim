let g:clap_provider_grep_delay = 50
let g:clap_provider_grep_opts = "-H --no-heading --vimgrep --smart-case --hidden -g !.git/"
let g:clap_layout = { 'relative': 'editor' }
let g:clap_insert_mode_only = 1
let g:clap_disable_run_rooter = 1
let g:clap_provider_buffers_cur_tab_only = 1
let g:clap_provider_grep_blink = [ 0, 0 ]

nn <silent> <leader>s :Clap grep ++query=<cword><cr>
vn <silent> <leader>s :Clap grep ++query=@visual<cr>
nn <silent> <leader>S :Clap grep<cr>
nn <silent> <leader>f :Clap files<cr>
nn <silent> <leader>b :Clap buffers<cr>
nn <silent> <leader>m :Clap history<cr>
nn <silent> <leader>: :Clap command_history<cr>
nn <silent> <leader>/ :Clap search_history<cr>
nn <silent> <leader>p :Clap projects<cr>


augroup clap_
  autocmd!
  au User ClapOnExit call lightline#update()
augroup END

let s:projects = {}

function! s:project_folders() abort
  let list = filter(
        \ map(copy(v:oldfiles), 'fnamemodify(v:val, ":h")."/"'),
        \ "isdirectory(v:val . '.git')")
  let dict = {}
  let result = []
  for l in list
    if has_key(dict, l) == 0
      let dict[l] = ''
      call add(result, l)
    endif
  endfor
  return result
endfunction

function! s:project_sink(selected) abort
  execute 'cd ' . a:selected
  execute 'NERDTree'
endfunction

let s:projects.syntax = 'clap_files'
let s:projects.sink = function('s:project_sink')
let s:projects.source = function('s:project_folders')
let s:projects.support_open_action = v:false

let g:clap_provider_projects = s:projects
