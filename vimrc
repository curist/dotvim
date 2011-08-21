set nocompatible

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
set hidden
set cursorline

set laststatus=2
set statusline=[%F]
set statusline+=\ [%{&fileencoding}, " encoding
set statusline+=%{&fileformat}]%m " file format
set statusline+=%=%{GitBranch()}\ %y\ %l,\ %c\ \<%P\>
set ofu=syntaxcomplete#Complete
set completeopt=longest,menu
let g:bufExplorerFindActive=0
let mapleader = ","
highlight Pmenu ctermbg=300 gui=bold

set list
set listchars=tab:>-,trail:-

set incsearch
set hlsearch
set wildmenu

augroup MyFileTypeSettings
    autocmd FileType ruby,eruby,yaml set ai sw=2 sts=2 et

    autocmd FileType man set number! " manpage don't show line number

    autocmd FileType c,h,cpp,hpp set cindent " exclusive use cindent for c and cpp

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
    autocmd FileType c,cpp,java,php,python,perl,ruby autocmd BufWritePre * :%s/\s\+$//e

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
    autocmd FileType html,xml inoremap > <ESC>:call InsertHtmlTag()<CR>a
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
        autocmd! User WokmarksChange :ShowMarksOn
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



autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
set completeopt=menu,menuone

nn <silent> <SPACE> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
nn <silent> <F12> :set number!<cr>
nn <silent> <F2> <ESC>:NERDTreeToggle<cr>
nn <silent> <F3> <ESC>:TagbarToggle<cr>
nn w!! w !sudo tee "%"
"nn gf :edit <cfile><cr>

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
