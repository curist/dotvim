let g:vimshell_split_command = 'split | resize 12'
let g:vimshell_disable_escape_highlight = 1


call vimshell#set_dictionary_helper(
      \ g:vimshell_interactive_interpreter_commands, 'clojure', 'lein repl')

call vimshell#set_dictionary_helper(
      \ g:vimshell_interactive_interpreter_commands, 'javascript', 'node')

autocmd FileType int-lein autocmd BufEnter <buffer> setlocal syntax=clojure filetype=clojure
autocmd FileType int-node autocmd BufEnter <buffer> setlocal syntax=javascript filetype=javascript
