let g:lsc_server_commands = {
      \ 'javascript': {
      \   'command': 'typescript-language-server --stdio',
      \   'log_level': -1,
      \   'suppress_stderr': v:true,
      \ },
      \ 'typescript': {
      \   'command': 'typescript-language-server --stdio',
      \   'log_level': -1,
      \   'suppress_stderr': v:true,
      \ },
      \ 'javascriptreact': {
      \   'command': 'typescript-language-server --stdio',
      \   'log_level': -1,
      \   'suppress_stderr': v:true,
      \ },
      \ 'typescriptreact': {
      \   'command': 'typescript-language-server --stdio',
      \   'log_level': -1,
      \   'suppress_stderr': v:true,
      \ },
      \ 'go': {
      \   'command': 'gopls serve',
      \    'log_level': -1,
      \    'suppress_stderr': v:true,
      \ },
      \ 'rust': {
      \   'command': 'rls',
      \    'log_level': -1,
      \    'suppress_stderr': v:true,
      \ },
      \}

let g:lsc_auto_map = v:true
