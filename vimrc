" !! plugin used list !! "
" supertab
" command-T
" autoclose
" matchit
" MRU
" wokmarks
" showmarks
" marksbrowser
" bufExplorer
" snipmate
" nerdtree
" tagbar
" repmo
" tabular
" pangloss/vim-javascript
" tpope/vim-rails
" tpope/vim-rake
""" sessionman
set nocompatible
"let $LANG="zh_TW.UTF-8"
set guifont=Inconsolata\ Medium\ 12
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,big5,euc-jp,gbk,euc-kr,utf-bom,iso8859-1
set t_Co=256
"desert256 herald tir_black moria baycomb inkpot xoria256 wombat256i vividchalk
colorscheme wombat256i
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab
set number
set mouse=n
autocmd FileType man set number! " manpage don't show line number
set nofen
set nowrap
set fdl=0
"set cindent
set autoindent
autocmd FileType c,cpp set cindent " exclusive use cindent for c and cpp
set backspace=indent,eol,start
set ignorecase
set smartcase
set hidden
set cursorline
"set autochdir
"set winaltkeys=no
call pathogen#infect()
syntax on
filetype on
filetype plugin on
filetype indent on

set laststatus=2
"set statusline=%F
set statusline=[%F]
set statusline+=\ [%{&fileencoding}, " encoding
set statusline+=%{&fileformat}]%m " file format
set statusline+=%=%{GitBranch()}\ %y\ %l,\ %c\ \<%P\>
set ofu=syntaxcomplete#Complete
set completeopt=longest,menu
set sessionoptions=buffers,curdir,help,resize,tabpages,winsize
let g:bufExplorerFindActive=0
let mapleader = ","
highlight Pmenu ctermbg=300 gui=bold

set list
autocmd FileType marksbuffer set list!

set listchars=tab:>-,trail:-

set incsearch
set hlsearch
set wildmenu


" mapping to make copy/paste to clipboard easier
vmap <leader>y "+y
nmap <leader>p "+p
nmap <leader>P "+P

" commandT mapping
let g:CommandTMaxHeight = 15
nn <leader>f :CommandTFlush<cr>

" supertab
let g:SuperTabDefaultCompletionType = "context"

" rails settings
let g:rubycomplete_rails = 1

" tex settings
let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat='pdf'
"let g:Tex_CompileRule_pdf='pdflatex -interaction=nonstopmode $*'
let g:Tex_CompileRule_pdf='xelatex -interaction=nonstopmode $*'
autocmd FileType tex set grepprg=grep\ -nH\ $*
autocmd FileType tex set sw=2
autocmd FileType tex set iskeyword+=:

" mark settings
let g:wokmarks_do_maps = 0
let g:wokmarks_pool = "abcdefghijklmnopqrstuvwxyz"
map mm <Plug>ToggleMarkWok
map mj <Plug>NextMarkWok
map mk <Plug>PrevMarkWok
nn mt :ShowMarksToggle<cr>
nn mc :ShowMarksClearAll<cr>
nn mb :MarksBrowser<cr>
" autocmd User WokmarksChange :ShowMarksOn
autocmd FileType vimwiki colorscheme desert256
autocmd FileType vimwiki set nocursorline
let g:showmarks_enable=0

" tintin++ setting
autocmd BufEnter,BufNew *.tt set syntax=tt

"" killing trailing spaces when saving file
autocmd FileType c,cpp,java,php,python,perl autocmd BufWritePre * :%s/\s\+$//e

autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
set completeopt=menu,menuone

nnoremap <SPACE> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

" c/c++ compiletion settings"
autocmd FileType c set mp=gcc\ -g\ -Wall\ %\ -o\ ~/bin/%:t:r
autocmd FileType cpp set mp=g++\ -g\ -Wall\ %\ -o\ ~/bin/%:t:r

" lua quickfix settings "
autocmd FileType lua setlocal mp=lua\ %
autocmd BufRead *.lua setlocal efm=lua:\ %f:%l:%m

" hot key mappings "
"autocmd FileType c nnoremap <leader>r :w<cr>:!gcc % -o ~/bin/%:t:r<cr>:!~/bin/%:t:r<cr>
autocmd FileType c nnoremap <leader>r :w<cr>:call MakeAndRun()<cr>
"autocmd FileType cpp nnoremap <leader>r :w<cr>:!g++ % -o ~/bin/%:t:r<cr>:!~/bin/%:t:r<cr>
autocmd FileType cpp nnoremap <leader>r :w<cr>:call MakeAndRun()<cr>
autocmd FileType cs nnoremap <leader>r :w<cr>:!mcs %<cr>:!mono %:r.exe<cr>
autocmd FileType java nnoremap <leader>r :w<cr>:!javac %<cr>:!java %:t:r<cr>
autocmd FileType python nnoremap <leader>r :w<cr>:!ipython %<cr>
autocmd FileType perl nnoremap <leader>r :w<cr>:!perl %<cr>
autocmd FileType lua nnoremap <leader>r :w<cr>:make<cr>

nn <F12> :set number!
map <F2> <ESC>:NERDTreeToggle<cr>
"map <F3> <ESC>:TlistToggle<cr>
map <F3> <ESC>:TagbarToggle<cr>
nn w!! w !sudo tee "%"
nn gf :edit <cfile><cr>


nn <c-j> <c-w>j
nn <c-k> <c-w>k
nn <c-l> <c-w>l
nn <c-h> <c-w>h


"NERDTree options"
let g:NERDTreeHighlightCursorline = 1
let g:NERDTreeChDirMode = 2
let g:NERDTreeQuitOnOpen = 0

" QUICKFIX WINDOW
command -bang -nargs=? QFix call QFixToggle(<bang>0)
function! QFixToggle(forced)
    if exists("g:qfix_win") && a:forced == 0
        cclose
        unlet g:qfix_win
    else
        copen 10
        let g:qfix_win = bufnr("$")
    endif
endfunction
nnoremap <leader>q :QFix<CR>

function! HasError(qflist)
    for i in a:qflist
        if i.valid == 1
            return 1
        endif
    endfor
    return 0
endfunction

function! MakeAndRun()
    make
    if HasError(getqflist())
        QFix
    else
        !~/bin/%:t:r
    endif
endfunction

function XmlAttribCallback (xml_tag)
    if a:xml_tag ==? "my-xml-tag"
        return "attributes=\"my xml attributes\""
    else
        return 0
    endif
endfunction

"auto update ctags"
function! UPDATE_TAGS()
    let _cmd_ = "ctags -R --c++-kinds=+p --fields=+iaS --extra=+q ."
    let _resp = system(_cmd_)
    unlet _cmd_
    unlet _resp
endfunction
autocmd BufWritePost *.cpp,*.h,*.c call UPDATE_TAGS()


function! InsertHtmlTag()
    let pat = '\c<\w\+\s*\(\s\+\w\+\s*=\s*[''#$;,()."a-z0-9]\+\)*\s*>'
    normal! a>
    let save_cursor = getpos('.')
    let result = matchstr(getline(save_cursor[1]), pat)
    if (search(pat, 'b', save_cursor[1]))
        normal! lyiwf>
        normal! a</
        normal! p
        normal! a>
    endif
    :call cursor(save_cursor[1], save_cursor[2], save_cursor[3])
endfunction
inoremap > <ESC>:call InsertHtmlTag()<CR>a
