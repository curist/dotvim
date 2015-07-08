set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

augroup Plugins
  " text manipulating helpers
  Plugin 'curist/vim-autoclose'
  Plugin 'tpope/vim-surround'
  Plugin 'tpope/vim-endwise'
  Plugin 'tpope/vim-commentary'
  Plugin 'transpose-words'
  Plugin 'vim-indent-object'
  " Plugin 'tpope/vim-ragtag'
  " Plugin 'godlygeek/tabular'

  " moving around:
  "   file/buffer switching
  "   in file quick jumps
  Plugin 'mru.vim'
  Plugin 'matchit.zip'
  Plugin 'bufexplorer.zip'
  Plugin 'scrooloose/nerdtree'
  Plugin 'kien/ctrlp.vim'
  Plugin 'tacahiroy/ctrlp-funky'
  Plugin 'mileszs/ack.vim'
  Plugin 'Tagbar'
  " Plugin 'JazzCore/ctrlp-cmatcher'

  " git
  Plugin 'tpope/vim-fugitive'
  Plugin 'gitignore'
  " Plugin 'gregsexton/gitv'

  " language specific
  Plugin 'vim-ruby/vim-ruby'
  Plugin 'tpope/vim-markdown'
  Plugin 'MatchTag'
  Plugin 'pangloss/vim-javascript'
  Plugin 'mxw/vim-jsx'
  Plugin 'digitaltoad/vim-jade'
  Plugin 'hail2u/vim-css3-syntax'
  Plugin 'fatih/vim-go'
  Plugin 'kennethzfeng/vim-raml'
  " Plugin 'tfnico/vim-gradle'
  " Plugin 'walm/jshint.vim'
  " Plugin 'curist/vim-angular-template'
  " Plugin 'tpope/vim-rails'
  " Plugin 'Shougo/javacomplete'
  " Plugin 'hsanson/vim-android'

  " special love for clojure
  Plugin 'guns/vim-clojure-static'
  Plugin 'tpope/vim-fireplace'
  Plugin 'tpope/vim-salve'
  Plugin 'tpope/vim-dispatch'
  Plugin 'guns/vim-sexp'
  Plugin 'tpope/vim-sexp-mappings-for-regular-people'

  " other handy plugins
  Plugin 'vimwiki'
  Plugin 'tpope/vim-repeat'
  Plugin 'SirVer/ultisnips'
  Plugin 'curist/git-symbol.vim'
  Plugin 'Valloric/YouCompleteMe'
  Plugin 'sjl/tslime.vim'
  Plugin 'tpope/vim-projectionist'
  Plugin 'wincent/terminus'
  " Plugin 'chrisbra/NrrwRgn'
  " Plugin 'scrooloose/syntastic'
  " Plugin 'sjl/gundo.vim'
  " Plugin 'jelera/vim-javascript-syntax'
  " Plugin 'henrik/vim-indexed-search'
  " Plugin 'haya14busa/incsearch.vim'
  " Plugin 'tpope/vim-classpath'
augroup END
call vundle#end()
