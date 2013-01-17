set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

runtime! config/**/*.vim

syntax on
filetype plugin indent on
language messages POSIX

set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,big5,euc-jp,gbk,euc-kr,utf-bom,utf-16le,iso8859-1

set t_Co=256
"desert256 herald tir_black lucius inkpot zenburn
"xoria256 wombat256i vividchalk molokai jellybeans
colorscheme molokai
set cursorline

set relativenumber
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab

set mouse=vn
set nowrap
set foldmethod=indent " fold by method (indent & syntax are both good)
set foldlevelstart=99 " we want all fold to be expand at start
set foldnestmax=15    " max fold nest levels
set autoindent
set backspace=indent,eol,start
set hidden     " it's ok to switch buffer w/o saving
set showcmd

set wildmenu

set laststatus=2                            " status bar setting
set statusline=[%F]                         " file name
set statusline+=\ [%{&fileencoding},        " encoding
set statusline+=%{&fileformat}]             " file format
set statusline+=%{&paste?'\ [PASTE]':''}    " paste mode status
set statusline+=%m                          " file modified?
set statusline+=%=                          " right align
set statusline+=%1*%{GitStatusSymbol()}%*   " git status symbol
set statusline+=\ %{fugitive#head(6)}       " git branch
set statusline+=\ %y                        " filetype
set statusline+=\ %c,\ %l\ \/\ %L           " cursor position, total lines


set list
set listchars=tab:▸\ ,trail:·,precedes:←,extends:→,nbsp:×
set showbreak=↪

set formatoptions-=o

set sidescroll=1

set ignorecase " ignore case in general
set smartcase  " when we typed something in Capitalized, be case sensitive
set incsearch
set hlsearch

set nobackup
set noswapfile
set backupdir=/tmp
set directory=/tmp

set shortmess+=I               " no intro message
set iminsert=1                 " to enable lmap
set nrformats=octal,hex,alpha  " ctrl-a to increment a-zA-Z
set virtualedit=block          " no limit cursor postion when in VISUAL BLOCK mode
set synmaxcol=500              " Don't try to highlight long lines


" NrrwRgn window maximize as default {{{2
autocmd BufEnter * let b:nrrw_aucmd_create = "%wincmd _"

" Helper functions/autocmds {{{1
" git status symbol {{{2
function! GitStatusSymbol()
  if !exists('b:git_dir')
    return ''
  endif
  return '⚡'
endfunction

" sync git status symbol color {{{2
hi User1 ctermfg=232 ctermbg=white cterm=reverse
function! SyncGitStatusSymbolColor()
  if !exists('b:git_dir')
    return
  endif
  let git_dir_is_dirty = system("git status -s --ignore-submodules=dirty")
  if git_dir_is_dirty != ''
    hi User1 ctermfg=232 ctermbg=red cterm=reverse,bold
  else
    hi User1 ctermfg=232 ctermbg=white cterm=reverse
  endif
endfunction

" Highlighting {{{2
function! Highlighting()
  " just in case..
  if &modifiable != 1
    return "\<cr>"
  endif

  " check if the current word is meaningful
  if expand('<cword>') =~ '^[a-zA-Z][a-zA-Z#_0-9]*$'
    let @/ = '\<'.expand('<cword>').'\>'
  endif
  return ":silent set hlsearch\<cr>:ShowSearchIndex\<cr>"
endfunction

" toggles the quickfix window. {{{2
command -bang -nargs=0 QFix call QFixToggle(<bang>0)
function! QFixToggle(forced)
  if exists("g:qfix_win") && a:forced == 0
    cclose
  else
    copen 10
  endif
endfunction

" use to track the quickfix window
augroup QFixToggle
  autocmd!
  autocmd BufWinEnter quickfix let g:qfix_win = bufnr("$")
  autocmd BufWinLeave * if exists("g:qfix_win") && expand("<abuf>") == g:qfix_win | unlet! g:qfix_win | endif
augroup END

" remove trailing spaces {{{2
function! KillTrailingSpaces()
  let l:save_cursor = getpos('.')
  :%s/\s\+$//e
  :call cursor(l:save_cursor[1], l:save_cursor[2], l:save_cursor[3])
endfunction

" add REMARK to sql statements {{{2
function! SqlRemarkWrapping()
  execute "norm ggOREMARK BEGIN"
  execute "norm Gk"
  if search(';', 'nW') == 0
    execute "norm Go;"
  endif
  execute "norm GoREMARK END"
endfunction

" git diff close {{{2
function! MyCloseDiff()
  if (&diff == 0 || getbufvar('#', '&diff') == 0)
        \ && (bufname('%') !~ '^fugitive:' && bufname('#') !~ '^fugitive:')
    echom "Not in diff view."
    return
  endif

  " close current buffer if alternate is not fugitive but current one is
  if bufname('#') !~ '^fugitive:' && bufname('%') =~ '^fugitive:'
    if bufwinnr("#") == -1
      b #
      bd #
    else
      bd
    endif
  else
    bd #
  endif
endfunction

" Save when losing focus {{{2
au FocusLost * :silent! wall

" Resize splits when the window is resized {{{2
au VimResized * :wincmd =

" change git status symbol color {{{2
au BufEnter,BufWritePost * call SyncGitStatusSymbolColor()

" }}}1

" Quirk dirty fixes {{{1
" }}}1

" Load project specific configs {{{1
if filereadable(expand("./.local_vimrc"))
  source ./.local_vimrc
endif
" Modeline {{{1
" vim: ts=4 sw=2 sts=2 et foldenable foldmethod=marker
