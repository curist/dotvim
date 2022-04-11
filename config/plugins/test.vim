let g:test#runner_commands = []

function! TmuxStrategy(cmd)
  execute 'VT tmux new-session "' . a:cmd . ' || tmux set -q remain-on-exit && tmux bind -n C-c \"kill-session;unbind C-c\""'
endfunction

let g:test#custom_strategies = {'tmux': function('TmuxStrategy')}
let g:test#strategy = 'tmux'

" let g:test#strategy = 'neovim'
let g:test#neovim#term_position = "vert botright"

nn <silent> <leader>tn :TestNearest<cr>
nn <silent> <leader>tl :TestLast<cr>
nn <silent> <leader>tf :TestFile<cr>

let g:test#go#gotest#options = '-v'
let g:test#javascript#jest#executable = 'npx jest'
let g:test#javascript#ava#file_pattern = '\v(__tests__/.*|(spec|test))\.(js|jsx|coffee|ts|tsx)$'
