local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
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
  use 'cocopon/vaffle.vim'
  use {'junegunn/fzf', run = ':call fzf#install()'}
  use 'junegunn/fzf.vim'
  use {'tracyone/fzf-funky', cmd = {'FzfFunky'}}

  -- git
  use 'tpope/vim-fugitive'
  use 'mhinz/vim-signify'

  -- programming language
  use {'sheerun/vim-polyglot', config = function()
    vim.g.polyglot_disabled = {'autoindent', 'sensible', 'vue'}
  end}
  use 'neovim/nvim-lspconfig'
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use 'dense-analysis/ale'
  use 'leafOfTree/vim-vue-plugin'

  -- ( love )
  use 'guns/vim-sexp'
  use 'Olical/conjure'
  use 'Olical/aniseed'

  -- get fancy
  use 'itchyny/lightline.vim'
  use 'norcalli/nvim-colorizer.lua'
  use 'lifepillar/vim-gruvbox8'
  use 'ryanoasis/vim-devicons'

  -- other handy plugins
  use 'tpope/vim-repeat'
  use 'mklabs/split-term.vim'
  use 'vim-test/vim-test'
end)
