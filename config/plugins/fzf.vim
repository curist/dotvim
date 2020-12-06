let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
let g:fzf_preview_window = ''

let $FZF_DEFAULT_COMMAND='rg --no-ignore-vcs --hidden --files'

nn <silent> <leader>f :GFiles<cr>
nn <silent> <leader>F :Files<cr>
nn <silent> <leader>m :History<cr>
nn <silent> <leader>c :Commands<cr>
nn <silent> <leader>b :Buffers<cr>
nn <silent> <leader>k :FzfFunky<cr>
nn <silent> <leader>/ :History/<cr>
nn <silent> <leader>: :History:<cr>
nn <silent> <leader>gl :BCommits<cr>
nn <silent> <leader>gL :Commits<cr>

command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0) 
nn <silent> <leader>S :Rg<cr>
nn <silent> <leader>s :Rg <c-r>=expand('<cword>')<cr><cr>

imap <c-x><c-l> <plug>(fzf-complete-line)

function! s:getVisualSelection()
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)

    if len(lines) == 0
        return ""
    endif

    let lines[-1] = lines[-1][:column_end - (&selection == "inclusive" ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]

    return join(lines, "\n")
endfunction

xn <silent> <leader>s <Esc>:Rg <c-r>=<SID>getVisualSelection()<cr><cr>

nn <silent> <leader>z :Rgg <c-r>=expand('<cword>')<cr><cr>
nn <silent> <leader>Z :Rgg<cr>
command! -bang -nargs=* Rgg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case --hidden --no-ignore-vcs -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)
