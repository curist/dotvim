set nocompatible
call pathogen#helptags()
call pathogen#infect()
syntax on
filetype on
filetype plugin indent on

set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,big5,euc-jp,gbk,euc-kr,utf-bom,iso8859-1

"desert256 herald tir_black moria baycomb inkpot xoria256 wombat256i vividchalk
colorscheme wombat256i
set t_Co=256
set cursorline
highlight Pmenu ctermbg=300 gui=bold

set tabstop=4
set shiftwidth=4
set expandtab
set smarttab
set number
set mouse=n
set nowrap
set nofen " no fold enable
set fdl=0 " folding level = 0
set autoindent
set backspace=indent,eol,start
set ignorecase
set smartcase
set hidden " it's ok to switch buffer w/o saving

set laststatus=2
set statusline=[%F]
set statusline+=\ [%{&fileencoding}, " encoding
set statusline+=%{&fileformat}]%m " file format
set statusline+=%=%{GitBranch()}\ %y\ %l,\ %c\ \<%P\>
set ofu=syntaxcomplete#Complete
set completeopt=longest,menu
let g:bufExplorerFindActive=0
let mapleader = ","

set list
set listchars=tab:>-,trail:-

set incsearch
set hlsearch
set wildmenu

set nobackup
set noswapfile

augroup MyFileTypeSettings
    autocmd FileType javascript,ruby,eruby,yaml set ai sw=2 sts=2 et
    " manpage don't show line number
    autocmd FileType man set number!

    " exclusive use cindent for c and cpp
    autocmd FileType c,h,cpp,hpp set cindent

    autocmd FileType marksbuffer set list!

    " vimwiki related..
    autocmd FileType vimwiki colorscheme desert256
    autocmd FileType vimwiki set nocursorline

    " c/c++ compiletion settings"
    autocmd FileType c set mp=gcc\ -g\ -Wall\ %\ -o\ ~/bin/%:t:r
    autocmd FileType cpp set mp=g++\ -g\ -Wall\ %\ -o\ ~/bin/%:t:r

    " lua quickfix settings "
    autocmd FileType lua setlocal mp=lua\ %
    autocmd BufRead *.lua setlocal efm=lua:\ %f:%l:%m

    " tintin++ setting
    autocmd BufEnter,BufNew *.tt set syntax=tt

    "" killing trailing spaces when saving file
    autocmd FileType c,cpp,java,php,python,perl,ruby,javascript,vim autocmd BufWritePre * :call KillTrailingSpaces()

    " run settings
    "autocmd FileType c nnoremap <leader>r :w<cr>:!gcc % -o ~/bin/%:t:r<cr>:!~/bin/%:t:r<cr>
    autocmd FileType c nnoremap <leader>r :w<cr>:call MakeAndRun()<cr>
    "autocmd FileType cpp nnoremap <leader>r :w<cr>:!g++ % -o ~/bin/%:t:r<cr>:!~/bin/%:t:r<cr>
    autocmd FileType cpp nnoremap <leader>r :w<cr>:call MakeAndRun()<cr>
    autocmd FileType cs nnoremap <leader>r :w<cr>:!mcs %<cr>:!mono %:r.exe<cr>
    autocmd FileType java nnoremap <leader>r :w<cr>:!javac %<cr>:!java %:t:r<cr>
    autocmd FileType python nnoremap <leader>r :w<cr>:!ipython %<cr>
    autocmd FileType perl nnoremap <leader>r :w<cr>:!perl %<cr>
    autocmd FileType lua nnoremap <leader>r :w<cr>:make<cr>
augroup END


" mapping to make copy/paste to clipboard easier
vmap <leader>y "+y
nmap <leader>p "+p
nmap <leader>P "+P

" commandT mapping
let g:CommandTMaxHeight = 15
nn <silent> <leader>f :CommandTFlush<cr>
nn <silent> <leader>v :CommandTBuffer<cr>

" supertab
let g:SuperTabDefaultCompletionType = "context"

" rails settings
let g:rubycomplete_rails = 1

" mark settings
function! ToggleShowMarks()
    if g:showmarks_enable == 0
        autocmd User WokmarksChange :ShowMarksOn
        :colorscheme wombat256i
    else
        autocmd! User WokmarksChange
    endif
    :ShowMarksToggle
endfunction

let g:wokmarks_do_maps = 0
let g:wokmarks_pool = "abcdefghijklmnopqrstuvwxyz"
map mm <Plug>ToggleMarkWok
map mj <Plug>NextMarkWok
map mk <Plug>PrevMarkWok
let g:showmarks_enable=0
nn <silent> mt :call ToggleShowMarks()<cr>
nn <silent> mc :delmarks a-z<cr>:ShowMarksOn<cr>:echo "All marks are cleared."<cr>
nn <silent> mb :MarksBrowser<cr>

nn <silent> <SPACE> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
nn <silent> <F12> :set number!<cr>
nn <silent> <F2> <ESC>:NERDTreeToggle<cr>
nn <silent> <F3> <ESC>:TagbarToggle<cr>
nn <silent> <leader>s :exec 'vimgrep /'.expand('<cword>').'/g **/*.rb **/*.erb **/*.yml **/*.js'<CR>
vn <c-c> <esc>
nn w!! w !sudo tee "%"

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
nnoremap <silent> <leader>q :QFix<CR>

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

"auto update ctags"
function! UPDATE_TAGS()
    let _cmd_ = "ctags -R --c++-kinds=+p --fields=+iaS --extra=+q ."
    let _resp = system(_cmd_)
    unlet _cmd_
    unlet _resp
endfunction
autocmd BufWritePost *.cpp,*.hpp,*.h,*.c call UPDATE_TAGS()

function! KillTrailingSpaces()
    let save_cursor = getpos('.')
    :%s/\s\+$//e
    :call cursor(save_cursor[1], save_cursor[2], save_cursor[3])
    unlet save_cursor
endfunction
