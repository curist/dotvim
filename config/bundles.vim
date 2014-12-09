set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

augroup Plugins
  " text manipulating helpers
  Plugin 'curist/vim-autoclose'
  Plugin 'godlygeek/tabular'
  Plugin 'tpope/vim-surround'
  Plugin 'tpope/vim-endwise'
  Plugin 'tpope/vim-commentary'
  Plugin 'transpose-words'
  Plugin 'vim-indent-object'

  " moving around:
  "   file/buffer switching
  "   in file quick jumps
  Plugin 'mru.vim'
  Plugin 'matchit.zip'
  Plugin 'bufexplorer.zip'
  Plugin 'scrooloose/nerdtree'
  Plugin 'kien/ctrlp.vim'
  Plugin 'tacahiroy/ctrlp-funky'
  Plugin 'JazzCore/ctrlp-cmatcher'
  Plugin 'mileszs/ack.vim'
  " Plugin 'Tagbar'

  " git
  Plugin 'tpope/vim-fugitive'
  Plugin 'gitignore'
  " Plugin 'gregsexton/gitv'

  " language specific
  Plugin 'vim-ruby/vim-ruby'
  Plugin 'tpope/vim-rails'
  Plugin 'tpope/vim-markdown'
  Plugin 'MatchTag'
  Plugin 'pangloss/vim-javascript'
  Plugin 'mxw/vim-jsx'
  Plugin 'digitaltoad/vim-jade'
  Plugin 'kchmck/vim-coffee-script'
  Plugin 'curist/javacomplete'
  Plugin 'walm/jshint.vim'
  Plugin 'hail2u/vim-css3-syntax'
  Plugin 'tpope/vim-classpath'
  Plugin 'guns/vim-clojure-static'
  Plugin 'tpope/vim-fireplace'
  Plugin 'Blackrush/vim-gocode'
  Plugin 'curist/vim-angular-template'
  Plugin 'wting/rust.vim'

  " other handy plugins
  Plugin 'vimwiki'
  Plugin 'tpope/vim-repeat'
  Plugin 'chrisbra/NrrwRgn'
  Plugin 'SirVer/ultisnips'
  Plugin 'curist/git-symbol.vim'
  Plugin 'Valloric/YouCompleteMe'
  " Plugin 'tpope/vim-projectionist'
  " Plugin 'scrooloose/syntastic'
  " Plugin 'sjl/gundo.vim'
  " Plugin 'jelera/vim-javascript-syntax'
  " Plugin 'henrik/vim-indexed-search'
  " Plugin 'haya14busa/incsearch.vim'
augroup END
call vundle#end()
