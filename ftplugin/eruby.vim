" This is for user-specific stuff in addition to the core plugin available here:
"   $VIMRUNTIME/ftplugin/eruby.vim
" See also:
"   $VIMRUNTIME/compiler/eruby.vim
"   $VIMRUNTIME/syntax/eruby.vim
"   $VIMRUNTIME/indent/eruby.vim

" Only do this when not done yet for this buffer
if (exists("b:did_per_user_ftplugin"))
  finish
endif
let b:did_per_user_ftplugin = 1

set tabstop=2
set shiftwidth=2	" Number of spaces to use for each step of (auto)indent. Should always match tabstop, in my opinion.
set expandtab

"imap <buffer> <CR> <C-R>=RubyEndToken()<CR>


iabbrev <% <% %><Left><Left><Backspace>
iabbrev <%= <%= %><Left><Left><Backspace>
