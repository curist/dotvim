(function(setup_plugins)
  function plug(...)
    local args = {...}
    local plug_name = args[1]
    local plug_args = args[2] or {x = 1}
    -- workaround lua `do` keyword
    plug_args['do'] = plug_args.run
    vim.call('plug#', plug_name, plug_args)
  end
  vim.call('plug#begin', '~/.config/nvim/plugged')
  setup_plugins(plug)
  vim.call('plug#end')
end)(function(Plug)
  -- text manipulating helpers
  Plug 'tpope/vim-surround'
  Plug 'tomtom/tcomment_vim'
  Plug 'kana/vim-textobj-user'
  Plug 'kana/vim-textobj-lastpat'
  Plug 'cohama/lexima.vim'
  Plug 'curist/highlight.vim'

  -- moving around:
  --   file/buffer switching
  --   in file quick jumps
  Plug('cocopon/vaffle.vim', { on = 'Vaffle' })
  Plug('junegunn/fzf', { run = ':call fzf#install()' })
  Plug 'junegunn/fzf.vim'
  Plug('tracyone/fzf-funky', { on = 'FzfFunky' })

  -- git
  Plug 'tpope/vim-fugitive'
  Plug('mhinz/vim-signify', { on = 'SignifyToggle' })

  -- programming language
  Plug('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
  Plug 'dense-analysis/ale'

  -- ( love )
  Plug 'guns/vim-sexp'
  Plug 'Olical/conjure'
  Plug('Olical/aniseed', { run = ':lua compileFennelConfig()' })

  -- get fancy
  Plug 'itchyny/lightline.vim'
  Plug 'lifepillar/vim-gruvbox8'

  -- other handy plugins
  Plug 'tpope/vim-repeat'
  Plug 'curist/split-term.vim'
  Plug 'vim-test/vim-test'
end)
