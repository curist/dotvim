set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

augroup Bundles
  " text manipulating helpers
  Bundle 'curist/vim-autoclose'
  Bundle 'godlygeek/tabular'
  Bundle 'tpope/vim-surround'
  Bundle 'tpope/vim-endwise'
  Bundle 'tpope/vim-commentary'
  Bundle 'transpose-words'
  Bundle 'vim-indent-object'

  " moving around:
  "   file/buffer switching
  "   in file quick jumps
  Bundle 'mru.vim'
  Bundle 'matchit.zip'
  Bundle 'bufexplorer.zip'
  Bundle 'scrooloose/nerdtree'
  Bundle 'Tagbar'
  Bundle 'kien/ctrlp.vim'
  Bundle 'tacahiroy/ctrlp-funky'
  Bundle 'JazzCore/ctrlp-cmatcher'
  Bundle 'mileszs/ack.vim'

  " git
  Bundle 'tpope/vim-fugitive'
  Bundle 'gregsexton/gitv'

  " language specific
  Bundle 'vim-ruby/vim-ruby'
  Bundle 'tpope/vim-rails'
  Bundle 'tpope/vim-markdown'
  Bundle 'MatchTag'
  Bundle 'pangloss/vim-javascript'
  Bundle 'digitaltoad/vim-jade'
  Bundle 'kchmck/vim-coffee-script'
  Bundle 'curist/javacomplete'
  Bundle 'walm/jshint.vim'
  Bundle 'hail2u/vim-css3-syntax'
  Bundle 'aaronj1335/underscore-templates.vim'
  Bundle 'tpope/vim-classpath'
  Bundle 'guns/vim-clojure-static'
  Bundle 'tpope/vim-fireplace'
  Bundle 'Blackrush/vim-gocode'
  Bundle 'derekwyatt/vim-scala'
  Bundle 'curist/vim-angular-template'
  Bundle 'applescript.vim'
  Bundle 'mustache/vim-mustache-handlebars'
  Bundle 'mxw/vim-jsx'

  " other handy plugins
  Bundle 'vimwiki'
  Bundle 'tpope/vim-repeat'
  Bundle 'chrisbra/NrrwRgn'
  Bundle 'SirVer/ultisnips'
  Bundle 'sjl/gundo.vim'
  Bundle 'henrik/vim-indexed-search'
  Bundle 'curist/git-symbol.vim'
  Bundle 'Valloric/YouCompleteMe'
  Bundle 'scrooloose/syntastic'
augroup END
