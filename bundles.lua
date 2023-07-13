(function(setup_plugins)
  vim.call('plug#begin', '~/.config/nvim/plugged')
  setup_plugins(function (name, args)
    args = args or { x = 1 }
    -- workaround lua `do` & `for` keyword
    args['do'] = args.run
    args['for'] = args.ft
    vim.call('plug#', name, args)
    if args.config and type(args.config) == 'function' then
      vim.schedule(args.config)
    end
  end)
  vim.call('plug#end')
end)(function(Plug)
  -- text manipulating helpers
  Plug 'tpope/vim-surround'
  Plug('tomtom/tcomment_vim', { on = 'TComment' })
  Plug 'cohama/lexima.vim'
  Plug 'curist/highlight.vim'

  -- moving around:
  --   file/buffer switching
  --   in file quick jumps
  Plug 'cocopon/vaffle.vim'
  Plug 'ibhagwan/fzf-lua'
  Plug 'phaazon/hop.nvim'
  -- Plug 'andymass/vim-matchup'

  -- tree-sitter
  Plug('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
  Plug('curist/tree-sitter-lx', { rtp = 'vim', run = ':TSInstall! lx' })
  -- Plug 'nvim-treesitter/playground'

  -- git
  Plug 'tpope/vim-fugitive'

  -- mason
  Plug 'williamboman/mason.nvim'

  -- specific programming language
  -- Plug('bfredl/nvim-luadev', { ft = 'lua' })
  -- Plug 'ziglang/zig.vim'

  -- get fancy
  Plug 'itchyny/lightline.vim'
  Plug 'curist/bogster'

  -- other handy plugins
  Plug 'tpope/vim-repeat'
end)
