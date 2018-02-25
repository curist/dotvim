call plug#begin('~/.config/nvim/plugged')

augroup Plugins
  " text manipulating helpers
  Plug 'curist/vim-autoclose'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-commentary'
  Plug 'vim-scripts/vim-indent-object'
  Plug 'kana/vim-textobj-user'
  Plug 'kana/vim-textobj-lastpat'
  " Plug 'vim-scripts/transpose-words'
  " Plug 'terryma/vim-multiple-cursors'
  " Plug 'tpope/vim-ragtag'
  " Plug 'godlygeek/tabular'

  " moving around:
  "   file/buffer switching
  "   in file quick jumps
  Plug 'vim-scripts/mru.vim'
  Plug 'vim-scripts/matchit.zip'
  Plug 'vim-scripts/bufexplorer.zip'
  Plug 'scrooloose/nerdtree'
  Plug 'mileszs/ack.vim'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  " Plug 'tacahiroy/ctrlp-funky'
  " Plug 'kien/ctrlp.vim'
  " Plug 'Tagbar', { 'on': 'TagbarToggle' }
  " Plug 'JazzCore/ctrlp-cmatcher', { 'do': './install.sh' }

  " git
  Plug 'tpope/vim-fugitive'
  Plug 'vim-scripts/gitignore'
  " Plug 'gregsexton/gitv'

  " good looking stuffs
  " Plug 'itchyny/lightline.vim'
  " Plug 'morhetz/gruvbox'


  " language specific
  Plug 'tpope/vim-markdown'
  Plug 'vim-scripts/MatchTag'
  Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
  Plug 'mxw/vim-jsx', { 'for': 'javascript' }
  Plug 'digitaltoad/vim-jade', { 'for': 'jade' }
  Plug 'hail2u/vim-css3-syntax', { 'for': 'css' }
  Plug 'fatih/vim-go', { 'for': 'go' }
  " Plug 'kennethzfeng/vim-raml', { 'for': 'raml' }
  " Plug 'wlangstroth/vim-racket', { 'for': 'racket' }
  " Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
  " Plug 'tfnico/vim-gradle'
  " Plug 'walm/jshint.vim'
  " Plug 'curist/vim-angular-template'
  " Plug 'tpope/vim-rails'
  " Plug 'Shougo/javacomplete'
  " Plug 'hsanson/vim-android'

  " special love for clojure
  Plug 'guns/vim-clojure-static', { 'for': 'clojure' }
  " Plug 'guns/vim-sexp', { 'for': 'clojure' }
  " Plug 'tpope/vim-sexp-mappings-for-regular-people', { 'for': 'clojure' }
  " Plug 'tpope/vim-dispatch'
  " Plug 'radenling/vim-dispatch-neovim'
  " Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
  " Plug 'tpope/vim-salve', { 'on': 'Console' }

  " other handy plugins
  Plug 'vim-scripts/vimwiki'
  Plug 'tpope/vim-repeat'
  Plug 'curist/git-symbol.vim'
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  " Plug 'Valloric/YouCompleteMe', { 'do': './install.sh' }
  " Plug 'SirVer/ultisnips'
  " Plug 'sjl/tslime.vim'
  " Plug 'tpope/vim-projectionist'
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
