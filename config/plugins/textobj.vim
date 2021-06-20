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
