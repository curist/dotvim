let g:ctrlp_extensions = []
let g:ctrlp_working_path_mode = 0
let g:ctrlp_custom_ignore = {
      \ 'dir':  '\.hg$\|\.svn$\|node_modules$\|bower_components$',
      \ 'file': '\.exe$\|\.so$\|\.dll$\|\.class$\|\.pyc$\|\.png$\|\.jpeg$\|\.jpg$\|\.gif$\|\.bmp$'
      \ }

let g:ctrlp_use_caching = 600
let g:ctrlp_match_func = {'match' : 'matcher#cmatch'}
