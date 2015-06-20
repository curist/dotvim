let g:tslime_normal_mapping = '<c-g><c-g>'
let g:tslime_visual_mapping = '<c-g><c-g>'
let g:tslime_vars_mapping = '<c-g>v'

let g:tmux_sessionname = system("tmux display-message -p '#S' | awk 1 ORS=''")
let g:tmux_windowname = system("tmux display-message -p '#I' | awk 1 ORS=''")
let g:tmux_panenumber = '1'
