call textobj#user#plugin('rootnode', {
\   '-': {
\     'select-a-function': 'GetCurrentRootNodeRange',
\     'select-a': 'ar',
\     'select-i-function': 'GetCurrentRootNodeRange',
\     'select-i': 'ir',
\   },
\ })

" outer rootnode selection should include spaces
function! GetCurrentRootNodeRange()
  return luaeval("require'dot.ts'.textobj.root_node()")
endfunction

call textobj#user#plugin('function', {
\   '-': {
\     'select-a-function': 'GetFunctionNodeRange',
\     'select-a': 'af',
\   },
\ })

function! GetFunctionNodeRange()
  return luaeval("require'dot.ts'.textobj.func()")
endfunction
