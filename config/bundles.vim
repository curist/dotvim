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
  Plugin 'JazzCore/ctrlp-cmatcher'
  Plugin 'mileszs/ack.vim'
  Plugin 'Tagbar'

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
  " Plugin 'walm/jshint.vim'
  " Plugin 'guns/vim-clojure-static'
  " Plugin 'tpope/vim-fireplace'
  " Plugin 'curist/vim-angular-template'
  " Plugin 'tpope/vim-rails'
  " Plugin 'Shougo/javacomplete'
  " Plugin 'tfnico/vim-gradle'
  " Plugin 'hsanson/vim-android'

  " other handy plugins
  Plugin 'vimwiki'
  Plugin 'tpope/vim-repeat'
  Plugin 'SirVer/ultisnips'
  Plugin 'curist/git-symbol.vim'
  Plugin 'Valloric/YouCompleteMe'
  " Plugin 'chrisbra/NrrwRgn'
  " Plugin 'tpope/vim-projectionist'
  " Plugin 'scrooloose/syntastic'
  " Plugin 'sjl/gundo.vim'
  " Plugin 'jelera/vim-javascript-syntax'
  " Plugin 'henrik/vim-indexed-search'
  " Plugin 'haya14busa/incsearch.vim'
  " Plugin 'tpope/vim-classpath'
augroup END
call vundle#end()
