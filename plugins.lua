local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd('packadd packer.nvim')
end

require('packer').startup(function(use)
  -- packer itself
  use 'wbthomason/packer.nvim'

  -- text manipulating helpers
  use 'tpope/vim-surround'
  use 'tpope/vim-abolish'
  use 'tomtom/tcomment_vim'
  use 'kana/vim-textobj-user'
  use 'kana/vim-textobj-lastpat'
  use 'curist/vim-autoclose'
  use 'curist/highlight.vim'
  use 'matze/vim-move'

  -- moving around:
  --   file/buffer switching
  --   in file quick jumps
  use {'cocopon/vaffle.vim', cmd = 'Vaffle', requires = {
  }}
  use {'junegunn/fzf', run = ':call fzf#install()'}
  use 'junegunn/fzf.vim'
  use {'tracyone/fzf-funky', cmd = 'FzfFunky'}

  -- git
  use 'tpope/vim-fugitive'
  use {'mhinz/vim-signify', cmd = 'SignifyToggle'}

  -- programming language
  use {'sheerun/vim-polyglot', config = function()
    vim.g.polyglot_disabled = {'autoindent', 'sensible', 'vue'}
  end}
  use 'neovim/nvim-lspconfig'
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use 'dense-analysis/ale'
  use 'leafOfTree/vim-vue-plugin'

  -- ( love )
  local lispy = {'clojure', 'scheme', 'fennel', 'lisp'}
  use {'guns/vim-sexp', ft = lispy}
  use {'Olical/conjure', ft = lispy}
  use {'Olical/aniseed', run = ':lua compileFennelConfig()' }

  -- get fancy
  use 'itchyny/lightline.vim'
  use 'norcalli/nvim-colorizer.lua'
  use 'lifepillar/vim-gruvbox8'
  use 'ryanoasis/vim-devicons'

  -- other handy plugins
  use 'tpope/vim-repeat'
  use {'mklabs/split-term.vim', cmd = {'Term', 'VTerm', 'TTerm'}}
  use 'vim-test/vim-test'
end)
