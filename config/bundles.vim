call plug#begin('~/.nvim/plugged')

augroup Plugins
  " text manipulating helpers
  Plug 'curist/vim-autoclose'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-commentary'
  Plug 'transpose-words'
  Plug 'vim-indent-object'
  Plug 'kana/vim-textobj-user'
  Plug 'kana/vim-textobj-lastpat'
  " Plug 'tpope/vim-ragtag'
  " Plug 'godlygeek/tabular'

  " moving around:
  "   file/buffer switching
  "   in file quick jumps
  Plug 'mru.vim'
  Plug 'matchit.zip'
  Plug 'bufexplorer.zip'
  Plug 'scrooloose/nerdtree'
  Plug 'kien/ctrlp.vim'
  Plug 'tacahiroy/ctrlp-funky'
  Plug 'mileszs/ack.vim'
  Plug 'Tagbar', { 'on': 'TagbarToggle' }
  " Plug 'JazzCore/ctrlp-cmatcher', { 'do': './install.sh' }

  " git
  Plug 'tpope/vim-fugitive'
  " Plug 'gitignore'
  " Plug 'gregsexton/gitv'

  " language specific
  Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
  Plug 'tpope/vim-markdown'
  Plug 'MatchTag'
  Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
  Plug 'mxw/vim-jsx', { 'for': 'javascript' }
  Plug 'digitaltoad/vim-jade', { 'for': 'jade' }
  Plug 'hail2u/vim-css3-syntax', { 'for': 'css' }
  Plug 'fatih/vim-go', { 'for': 'go' }
  Plug 'kennethzfeng/vim-raml', { 'for': 'raml' }
  Plug 'wlangstroth/vim-racket', { 'for': 'racket' }
  " Plug 'tfnico/vim-gradle'
  " Plug 'walm/jshint.vim'
  " Plug 'curist/vim-angular-template'
  " Plug 'tpope/vim-rails'
  " Plug 'Shougo/javacomplete'
  " Plug 'hsanson/vim-android'

  " special love for clojure
  Plug 'guns/vim-clojure-static'
  Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
  Plug 'guns/vim-sexp', { 'for': 'clojure' }
  Plug 'tpope/vim-sexp-mappings-for-regular-people', { 'for': 'clojure' }
  Plug 'tpope/vim-dispatch'
  Plug 'radenling/vim-dispatch-neovim'
  Plug 'tpope/vim-salve', { 'for': 'clojure' }

  " other handy plugins
  Plug 'vimwiki'
  Plug 'tpope/vim-repeat'
  Plug 'SirVer/ultisnips'
  Plug 'curist/git-symbol.vim'
  Plug 'Valloric/YouCompleteMe', { 'do': './install.sh' }
  Plug 'sjl/tslime.vim'
  Plug 'tpope/vim-projectionist'
  " Plug 'wincent/terminus'
  " Plug 'chrisbra/NrrwRgn'
  " Plug 'scrooloose/syntastic'
  " Plug 'sjl/gundo.vim'
  " Plug 'jelera/vim-javascript-syntax'
  " Plug 'henrik/vim-indexed-search'
  " Plug 'haya14busa/incsearch.vim'
  " Plug 'tpope/vim-classpath'
augroup END
call plug#end()
