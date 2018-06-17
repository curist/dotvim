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
  Plug 'sheerun/vim-polyglot'
  Plug 'mhartington/nvim-typescript', { 'do': './install.sh' }
  Plug 'fatih/vim-go', { 'do': 'GoUpdateBinaries' }

  " other handy plugins
  Plug 'vim-scripts/vimwiki'
  Plug 'tpope/vim-repeat'
  Plug 'vim-scripts/MatchTag'
  Plug 'curist/git-symbol.vim'
  Plug 'SirVer/ultisnips'
  " Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'roxma/nvim-completion-manager'
  " Plug 'Valloric/YouCompleteMe', { 'do': './install.sh' }
  " Plug 'sjl/tslime.vim'
  " Plug 'tpope/vim-projectionist'
  " Plug 'wincent/terminus'
  " Plug 'chrisbra/NrrwRgn'
  " Plug 'scrooloose/syntastic'
  " Plug 'sjl/gundo.vim'
  " Plug 'henrik/vim-indexed-search'
  " Plug 'haya14busa/incsearch.vim'
  " Plug 'tpope/vim-classpath'
augroup END
call plug#end()
