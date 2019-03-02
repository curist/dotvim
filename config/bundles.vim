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
  Plug 'curist/highlight.vim'
  " Plug 'vim-scripts/transpose-words'

  " moving around:
  "   file/buffer switching
  "   in file quick jumps
  Plug 'vim-scripts/mru.vim'
  Plug 'vim-scripts/matchit.zip'
  Plug 'vim-scripts/bufexplorer.zip'
  Plug 'scrooloose/nerdtree'
  Plug 'mileszs/ack.vim'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  " Plug 'tacahiroy/ctrlp-funky'
  " Plug 'kien/ctrlp.vim'
  " Plug 'Tagbar', { 'on': 'TagbarToggle' }

  " git
  Plug 'tpope/vim-fugitive'
  Plug 'vim-scripts/gitignore'
  Plug 'junegunn/gv.vim'


  " language specific
  Plug 'sheerun/vim-polyglot'

  " get fancy
  Plug 'chriskempson/base16-vim'
  Plug 'whatyouhide/vim-gotham'

  " completion
  Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
  Plug 'mbbill/echofunc'
  " Plug 'autozimu/LanguageClient-neovim', {
  "       \ 'branch': 'next',
  "       \ 'do': 'bash install.sh',
  "       \ }
  " Plug 'ncm2/ncm2'
  " Plug 'roxma/nvim-yarp' " required by ncm2

  " other handy plugins
  Plug 'vim-scripts/vimwiki'
  Plug 'tpope/vim-repeat'
  Plug 'vim-scripts/MatchTag'
  Plug 'curist/git-symbol.vim'
  Plug 'SirVer/ultisnips'
  Plug 'mklabs/split-term.vim'
  " Plug 'tpope/vim-projectionist'
  " Plug 'wincent/terminus'
  " Plug 'chrisbra/NrrwRgn'
  " Plug 'scrooloose/syntastic'
  " Plug 'sjl/gundo.vim'
augroup END
call plug#end()
